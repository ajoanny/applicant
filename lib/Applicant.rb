require "thor"
require "dotenv/load"
require_relative "Applicant/version"
require_relative "Applicant/commands/generation"

Signal.trap("INT") do
  puts "\nSIGINT received, exiting gracefully..."
  exit(1)
end

module Applicant
  class CLI < Thor
    def self.check_env!
      required_variables = %w(LLM_MODEL OLLAMA_URL)

      missing_variables = required_variables.select { |var| ENV[var].nil? }
      if missing_variables.any?
        puts "Error: missing environment variables: #{missing_variables.join(', ')}"
        exit(1)
      end
    end

    check_env!

    desc "generate", "Generate a cover letter using the job description pasted into the terminal and a cover letter."
    method_option :cover_letter, default: './config/cover-letter.txt', desc: "The path to the cover letter file"
    method_option :job, type: :string, desc: "The path to the job description file"
    def generate
      cover_letter = options[:cover_letter]

      if options[:job]
        job_description = File.read(options[:job])
      else
        puts "paste the job description then EOF"
        job_description = STDIN.read
      end

      Applicant::Commands::Generation
        .new(ENV['LLM_MODEL'], ENV['OLLAMA_URL'])
        .generate(job_description, cover_letter)
    end

    def self.exit_on_failure?
      true
    end
  end
end
