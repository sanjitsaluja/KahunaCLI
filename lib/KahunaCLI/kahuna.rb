require 'KahunaCLI/logs'

module KahunaCLI
  class Kahuna < Thor
  	desc "logs COMMANDS", "Kahuna Logs API"
    subcommand 'logs', KahunaCLI::Logs
  end
end