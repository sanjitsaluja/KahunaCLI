module KahunaCLI
  class Logs < Thor
  	
  	desc "stream", "This will stream logs starting from Time.now"
    long_desc <<-HELLO_WORLD

    `stream` will print out logs starting from Time.now
    HELLO_WORLD
    def stream
      cursor = fetch_first_cursor
      while 1 do 
        response = fetch_with_cursor(cursor)
        cursor = response.cursor
        sleep 1
      end
    end

    private

    def fetch_first_cursor
      logs = KahunaCLI.kahuna_client.logs(timestamp:Time.now, number_of_records:1)
      logs.cursor
    end

    def fetch_with_cursor(cursor)
      response = KahunaCLI.kahuna_client.logs({cursor:cursor, number_of_records:1000})
      push_logs = response.push
      push_logs.each do |push|
        puts "\n"
        puts push.to_json
        puts "\n"
      end
      response
    end

  end
end