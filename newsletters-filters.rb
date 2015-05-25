#!/bin/env ruby

require 'rubygems'
require 'gmail-britta'

if File.exist?(File.expand_path("~/.my-email-addresses.rb"))
  require "~/.my-email-addresses.rb"
else
  # Some fake constants to let you run this (-:
  MY_EMAILS = %w[test@example.com test.tester@example.com]
end

fs = GmailBritta.filterset(:me => MY_EMAILS) do

  [
    {:list => 'idm',         :has => ['to:(idm@hyperreal.org)'], :archive => true, :mark_read => true},
    {:list => 'js-weekly',   :has => ['list:"0618f6a79d6bb9675f313ceb2.613734.list-id.mcsv.net"'], :star => true},
    {:list => 'ruby-weekly', :has => ['list:"0618f6a79d6bb9675f313ceb2.612785.list-id.mcsv.net""'], :star => true},
  ].each do |config|
    filter {
      has config[:has]
      label ".list/#{config[:list]}"
      archive if config[:archive]
      star if config[:star]
    }.also {
      label ".list"
    }
  end

end

puts fs.generate
