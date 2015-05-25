#!/bin/env ruby

require 'rubygems'
require 'gmail-britta'


Dir[File.dirname(__FILE__) + "/lib/**/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/config/**/*.rb"].each {|file| require file }

if File.exist?(File.expand_path("~/.my-email-addresses.rb"))
  require "~/.my-email-addresses.rb"
else
  # Some fake constants to let you run this (-:
  MY_EMAILS = %w[test@example.com test.tester@example.com]
end

fs = GmailBritta.filterset(:me => MY_EMAILS) do

  # puts FilterConfig.configs
  FilterConfig.configs.each do |root_label, label_configs|

    label_configs.each do |conf|
      filter {
        has conf[:has]
        label "#{root_label}/#{conf[:label]}"

        archive           if conf[:archive]
        star              if conf[:star]
        mark_read         if conf[:mark_read]
        mark_important    if conf[:mark_important]
        mark_unimportant  if conf[:mark_unimportant]
        never_spam        if conf[:never_spam]
        delete_it         if conf[:delete_it]

      }.also {
        label root_label
      }
    end

  end

  phrases = FilterConfig.phrases

  MY_EMAILS.each do |e|
    phrases <<   "\"this message was sent to #{e}\""
  end

  phrases.each_slice(5) do |phrase_group|
    filter {
      has [{:or => phrase_group}]

      archive
      label '.unsub'
      mark_unimportant
    }
  end

end

puts fs.generate
