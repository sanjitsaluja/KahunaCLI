require 'faraday'
require 'KahunaCLI/version'

module KahunaCLI
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {NYCGeoClient::API}
    VALID_OPTIONS_KEYS = [
      :api_key, #password BasicAuthentication
      :secret_key, #username BasicAuthentication
      :endpoint,
      :environment, # (s = sandbox, p = production)
      :debug
    ].freeze

    # By default, don't set an API Key
    DEFAULT_API_KEY = nil

    # By default, don't set a Secret Key
    DEFAULT_SECRET_KEY = nil

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://tap-nexus.appspot.com/'.freeze

    # By default, dont' log the request/response
    DEFAULT_DEBUG = false

    # By default, use sandbox as environment
    DEFAULT_ENVIRONMENT = 's'
    
    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
      load_config(base)
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.api_key        = DEFAULT_API_KEY
      self.secret_key     = DEFAULT_SECRET_KEY
      self.endpoint       = DEFAULT_ENDPOINT
      self.environment    = DEFAULT_ENVIRONMENT
      self.debug          = DEFAULT_DEBUG
    end

    def self.load_config(base)
      defaults = ::YAML::load_file(config_file) || {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        value = defaults[key.to_s]
        base.send("#{key}=", defaults[key.to_s]) if value
      end
    end

    def self.config_file
      File.expand_path(File.join('~', '.KahunaCLI'))
    end
  end
end