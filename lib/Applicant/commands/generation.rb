require "net/http"
require 'json'

module Applicant
  module Commands
    class Generation

      def initialize model, ollama_url
        @model = model
        @ollama_url=ollama_url
      end

      def generate job_description, cover_letter_path
        self.post({
          model: @model,
          stream: true,
          messages: [
            {
              role:  'user',
              content: File.read('./config/task.txt')
            },
            {
              role:  'user',
              content: "CV: #{File.read(cover_letter_path)}"
            },
            {
              role:  'user',
              content: "JOB: #{job_description}"
            },
          ]
        })
      end

      def post data
        puts "\nGeneration with #{@model}\n"
        uri = URI("#{@ollama_url}/api/chat")
        http = Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = 10
        http.read_timeout =60*5

        request = Net::HTTP::Post.new(uri)
        request["Content-Type"] = "application/json"
        request.body = data.to_json
        http.request(request) do |response|
          response.read_body do |chunk|
            response_parsed = JSON.parse(chunk)
            print response_parsed['message']['content']
          end
        end
      end
    end
  end
end
