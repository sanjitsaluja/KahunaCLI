require 'colorize'
module KahunaCLI
  class Logs < Thor
  	
  	desc "stream", "Stream logs starting from Time.now"
    long_desc <<-HELLO_LOGS

    `stream` will fetch & display logs from Kahuna every 
    few seconds.
    HELLO_LOGS

    method_option :json, 
      :aliases => "-j",
      :default => false,
      :desc => "Dump logs in JSON format"      

    method_option :human_readable, 
      :aliases => "-h",      
      :default => true,
      :desc => "Format in to be human readable"

    method_option :poll_time,
      :default => 1,
      :type => :numeric,
      :desc => "Poll time in seconds"

    def stream
      @log_formatter = LogFormatter.new(options)
      cursor = fetch_first_cursor
      while cursor do 
        response = fetch_logs_with_cursor(cursor)
        if response
          cursor = response.cursor
          push_logs = response.push
          display_logs(push_logs, options)
        end
        begin
          sleep 1 
        rescue Interrupt
          break
        end
      end
    end

    private

    def fetch_first_cursor
      begin
        logs = KahunaCLI.kahuna_client.logs(timestamp:Time.now, number_of_records:1)
        logs.cursor
      rescue Interrupt
      end
    end

    def fetch_logs_with_cursor(cursor)
      begin
        KahunaCLI.kahuna_client.logs({cursor:cursor, number_of_records:1000})
      rescue Interrupt
      end
    end

    def display_logs(push_logs, options)
      push_logs.each do |log|
        puts "\n"
        if options[:json]
          puts log.to_json
        else
          @log_formatter.print_log(log)
        end
        puts "\n"
      end
    end

  end
end