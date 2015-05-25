#!/bin/env ruby

require 'rubygems'
require 'gmail-britta'

if File.exist?(File.expand_path("~/.my-email-addresses.rb"))
  require "~/.my-email-addresses.rb"
else
  # Some fake constants to let you run this (-:
  MY_EMAILS = %w[test@example.com test.tester@example.com]
end

phrases = [
  '"to view this email as a web page, go here."',
  '"having trouble reading this email"',
  '"having trouble viewing this email"',
  '"email not displaying correctly"',
  '"unsubscribe | change subscriber options"',
  '"unsubscribe from this list"',
  '"unsubscribe instantly"',
  '"please unsubscribe"',
  '"update subscription preferences"',
  '"email preferences"',
  '"follow the URL below to update your preferences or opt-out"',
  '"if you would rather not receive future communications from"',
  '"if you would like to unsubscribe"',
  '"to ensure that you continue receiving our emails"',
  '"please add us to your address book or safe list."',
  '"safeunsubscribe"',
  '"to unsubscribe"',
  '"unsubscribe from these emails"',
  '"unsubscribe from our emails"',
  '"unsubscribe please click"',
  '"unsubscribe from future"',
  '"you can unsubscribe here"',
  '"to unsubscribe or change subscriber options"',
  '"this email has been sent to you by"',
  '"to opt out"',
  '"opt out using TrueRemove"',
  '"one-click unsubscribe"',
  '"do not reply to this email"',
  '"view this email in a browser"',
  '"please do not reply to this message."',
  '"if you no longer wish to receive our emails"',
  '"if you do not wish to receive email from"',
  '"no longer receive this newsletter"',
  '"do not want to receive any newsletters"',
  '"to remove this e-mail address from"',
  '"removed from this mailing list"',
  '"manage your email settings"',
  '"edit your subscription"',
  '"you may unsubscribe"',
  '"you can unsubscribe"',
  '"powered by YMLP"',
  '"update your contact information"',
  '"update your contact details"',
  '"change your subscription settings"',
  '"manage your subscription"',
  '"manage your subscriptions"',
  '"update Email Address or Unsubscribe"',
  '"this email was sent by"',
  '"this email was intended for"',
  '"you received this email because"',
  '"you received this e-mail because"',
  '"you are receiving this message"',
  '"prefer not to receive invites from"',
  '"Remove me from this list"',
  '"Remove yourself from this list"',
  '"To stop receiving emails"',
  '"please add us to your address book"',
  '"Forward this email to a friend"',
  '"Forward to a friend"',
  '"If you no longer want us to contact you"',
  '"Rather not receive future emails"',
  '"We hope you enjoyed receiving this message"',
  '"prefer not to receive newsletters from"',
  '"Cliquer ici pour vous désinscrire"',
  '"block the sender"',
  '"report this message"',
  '"You\'re receiving this e-mail because you\'ve signed up for"',
]

MY_EMAILS.each do |e|
  phrases <<   "\"this message was sent to #{e}\""
end
fs = GmailBritta.filterset(:me => MY_EMAILS) do
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
