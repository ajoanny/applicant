#!/usr/bin/env ruby
require "bundler/setup"
require "Applicant"

Applicant::CLI.start(ARGV)