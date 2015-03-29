require 'thor'
require 'yaml'
require 'kahuna_client'
require 'KahunaCLI/version'
require 'KahunaCLI/configuration'
require 'KahunaCLI/kahuna'
require 'KahunaCLI/log_formatter'

String.disable_colorization = false

module KahunaCLI
  extend Configuration
  
  def self.kahuna_client
  	KahunaClient::Client.new(options)
  end
end
