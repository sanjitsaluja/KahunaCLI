module KahunaCLI
  class LogFormatter
    def initialize(options)
      @fields_to_display = options[:fields]
    end

    def print_log(log)
      @log = log

      print_log_component('os', :red)
      print_log_component('credentials', :green)      
      print_log_component('campaign', :blue)
      print_log_component('timestamp', :green)
      print_log_component('action', :green)
      print_log_component('message')
      print_log_component('push_token')
      
      # Push Token
    end

    def print_log_component(key, text_color = nil, background_color = nil)
      print_key_value(key, @log[key.to_sym].to_s, text_color, background_color)
    end

    def print_key_value(key, value, text_color, background_color)
      printf '%-14s', "#{key} "
      puts value.colorize(text_color)
    end
  end
end