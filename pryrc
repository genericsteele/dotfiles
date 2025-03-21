Pry.config.color = true
Pry.config.editor = 'vim'
if defined?(Rails) && Rails.env
  require 'logger'

  if defined?(ActiveRecord)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.clear_active_connections!
  end
end
if defined?(PryRails::RAILS_PROMPT)
  Pry.config.prompt = PryRails::RAILS_PROMPT
end
