return {
  "nvim-neotest/neotest",
  adapters = {
    ["neotest-rspec"] = {
      rspec_cmd = function()
        return vim
          .iter({
            "bundle",
            "exec",
            "rspec",
            "--no-profile",
          })
          :flatten()
      end,
    },
  },
}
