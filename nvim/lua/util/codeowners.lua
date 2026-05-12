local M = {}

local CODEOWNERS_LOCATIONS = { "CODEOWNERS", ".github/CODEOWNERS", "docs/CODEOWNERS" }

local parsed_cache = {}

local function compile_glob(glob)
  local anchored = glob:sub(1, 1) == "/"
  if anchored then
    glob = glob:sub(2)
  end

  local dir_only = glob:sub(-1) == "/"
  if dir_only then
    glob = glob:sub(1, -2)
  end

  local has_slash = glob:find("/") ~= nil

  local out, i = {}, 1
  while i <= #glob do
    local c = glob:sub(i, i)
    if c == "*" and glob:sub(i + 1, i + 1) == "*" then
      out[#out + 1] = ".*"
      i = i + 2
    elseif c == "*" then
      out[#out + 1] = "[^/]*"
      i = i + 1
    elseif c == "?" then
      out[#out + 1] = "[^/]"
      i = i + 1
    elseif c:match("[%^%$%(%)%%%.%[%]%+%-]") then
      out[#out + 1] = "%" .. c
      i = i + 1
    else
      out[#out + 1] = c
      i = i + 1
    end
  end
  local body = table.concat(out)

  if not anchored and not has_slash then
    if dir_only then
      return { kind = "dir_segment", segment = glob }
    end
    return { kind = "basename", pattern = "^" .. body .. "$" }
  end

  if dir_only then
    return { kind = "path_prefix", pattern = "^" .. body .. "/" }
  end
  return {
    kind = "path_exact",
    pattern_exact = "^" .. body .. "$",
    pattern_prefix = "^" .. body .. "/",
  }
end

local function rule_matches(rule, relpath)
  if rule.kind == "basename" then
    for seg in relpath:gmatch("[^/]+") do
      if seg:match(rule.pattern) then
        return true
      end
    end
    return false
  elseif rule.kind == "dir_segment" then
    return ("/" .. relpath):find("/" .. rule.segment .. "/", 1, true) ~= nil
  elseif rule.kind == "path_exact" then
    return relpath:match(rule.pattern_exact) ~= nil or relpath:match(rule.pattern_prefix) ~= nil
  else
    return relpath:match(rule.pattern) ~= nil
  end
end

local function parse_codeowners(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local rules = {}
  for line in f:lines() do
    local stripped = line:gsub("#.*$", ""):gsub("^%s+", ""):gsub("%s+$", "")
    if stripped ~= "" then
      local tokens = {}
      for tok in stripped:gmatch("%S+") do
        tokens[#tokens + 1] = tok
      end
      if #tokens >= 2 then
        local rule = compile_glob(tokens[1])
        rule.owners = { select(2, unpack(tokens)) }
        rules[#rules + 1] = rule
      end
    end
  end
  f:close()
  return rules
end

local function get_rules(codeowners_path, mtime)
  local cached = parsed_cache[codeowners_path]
  if cached and cached.mtime == mtime then
    return cached.rules
  end
  local rules = parse_codeowners(codeowners_path)
  if rules then
    parsed_cache[codeowners_path] = { mtime = mtime, rules = rules }
  end
  return rules
end

local function find_git_root(start_path)
  local hit = vim.fs.find(".git", { path = start_path, upward = true })[1]
  if hit then
    return vim.fs.dirname(hit)
  end
end

local function find_codeowners(root)
  for _, loc in ipairs(CODEOWNERS_LOCATIONS) do
    local p = root .. "/" .. loc
    local stat = vim.uv.fs_stat(p)
    if stat then
      return p, stat.mtime.sec
    end
  end
end

function M.get_owner(bufnr)
  bufnr = (bufnr == nil or bufnr == 0) and vim.api.nvim_get_current_buf() or bufnr

  if vim.bo[bufnr].buftype ~= "" then
    return nil
  end
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then
    return nil
  end

  local root = find_git_root(path)
  if not root then
    return nil
  end

  local codeowners_path, mtime = find_codeowners(root)
  if not codeowners_path then
    return nil
  end

  local cache = vim.b[bufnr].codeowner_cache
  if cache and cache.path == path and cache.codeowners == codeowners_path and cache.mtime == mtime then
    return cache.owner or nil
  end

  local rules = get_rules(codeowners_path, mtime)
  if not rules then
    return nil
  end

  local relpath = path:sub(#root + 2)

  local owner
  for i = #rules, 1, -1 do
    if rule_matches(rules[i], relpath) then
      owner = rules[i].owners[1]
      break
    end
  end

  vim.b[bufnr].codeowner_cache = {
    path = path,
    codeowners = codeowners_path,
    mtime = mtime,
    owner = owner or false,
  }

  return owner
end

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(function()
      vim.b[buf].codeowner_cache = nil
    end)
  end
end

return M
