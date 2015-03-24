require 'thor'
require 'yaml'
require 'kahuna_client'
require 'KahunaCLI/version'
require 'KahunaCLI/configuration'
require 'KahunaCLI/kahuna'

module KahunaCLI
  extend Configuration
  
  def self.kahuna_client
  	KahunaClient::Client.new(options)
  end
end
