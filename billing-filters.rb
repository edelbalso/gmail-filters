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

  # Online Shopping
  # filter {
  #   amazon_emails = %w{
  #     auto-shipping@amazon.co.uk
  #     auto-confirm@amazon.co.uk
  #     order-update@amazon.co.uk
  #     digital-no-reply@amazon.co.uk
  #     noreply@despatch.net
  #     yourdelivery@dpd.co.uk
  #     aws-receivables@amazon.com
  #   }
  #   has [{:or => "from:(#{amazon_emails.join("|")})"}]
  #   label 'Finance/amazon'
  #   never_spam
  # }

  # filter {
  #   online_shop_emails = %w{
  #     support@github.com
  #   }
  #   has [{:or => "from:(#{online_shop_emails.join("|")})"}]
  #   label 'Receipts'
  #   never_spam
  # }

  apple_emails = %w{
    do_not_reply@itunes.com
    do_not_reply@apple.com
  }

  [
    # Groceries
    { :grp => '.rcpt/.groceries', :has => ['from:(orders@instacart.com)'] },

    # Transportation
    { :grp => '.rcpt/.transport', :has => ['from:(@scootnetworks.com) subject:("receipt")'] },
    { :grp => '.rcpt/.transport', :has => ['from:(receipts @uber.com)'] },
    { :grp => '.rcpt/.transport', :has => ['from:(supportsf@uber.com) subject:(receipt)'] },
    { :grp => '.rcpt/.transport', :has => ['from:(no-reply@lyftmail.com "receipt")'] },
    { :grp => '.rcpt/.transport', :has => ['from:(no-reply@lyftmail.com) subject:("receipt")'] },

    # Software Tools
    { :grp => '.rcpt/.software',  :has => ["from:(support@github.com)", 'subject:("[GitHub] Payment Receipt")'] },
    { :grp => '.rcpt/.software',  :has => ["from:(billing@xero.com)"] },
    { :grp => '.rcpt/.software',  :has => ["from:(info@put.io) subject:(receipt)"] },

    # Hosting
    { :grp => '.rcpt/.hosting',   :has => ["from:(billing@dreamhost.com)"] },

    # Expensable
    { :grp => '.rcpt/.business',  :has => ["from:(@gogoair.com) subject:(receipt|purchase)"] },

    # food
    { :grp => '.rcpt/.food',      :has => ["from:(no-reply@postmates.com) subject:(receipt|delivery from complete)"] },

    # square
    { :grp => '.rcpt/.square',    :has => ['from:(messaging.squareup.com) subject:(receipt)'] },

    # Misc
    { :grp => '.rcpt/.misc',      :has => [{:or => "from:(#{apple_emails.join("|")})"}, 'subject:(receipt)'] },
    { :grp => '.rcpt/.misc',      :has => ['from:(service@paypal.com) subject:(Your payment)'] },
    { :grp => '.rcpt/.misc',      :has => ['@google.com subject:(receipt)'] },

  ].each do |filter_config|
    filter {
      has filter_config[:has]
      # label filter_config[:cat]
      never_spam
      mark_unimportant
      archive if filter_config[:archive]
    }.also {
      label filter_config[:grp]
    }.also {
      label '.rcpt'
    }
  end

  # Transportation
  # filter {
  #   has ['from(receipts uber) from:(receipts.san.francisco@uber.com)']
  #   label 'Uber/San Francisco'
  #   never_spam
  #   mark_unimportant
  # }.otherwise {
  #   has ['from(receipts uber) from:(receipts.new.york@uber.com)']
  #   label 'Uber/New York'
  #   never_spam
  #   mark_unimportant
  # }.also {
  #   label 'Uber'
  # }

  # filter {
  #   travel_emails = %w{
  #     accorhotels.reservation@accor.com
  #     noreply@eastcoast.co.uk
  #     webmaster@travelodge.co.uk
  #     autoresponse@tfl.gov.uk
  #   }
  #   has [{:or => "from:(#{travel_emails.join("|")})"}]
  #   label 'billing & banking/travel'
  #   never_spam
  # }
  #
  # filter {
  #   has %w{from:Expedia@uk.expediamail.com subject:confirmation}
  #   label 'billing & banking/travel'
  #   never_spam
  # }.otherwise {
  #   has %w{from:Expedia@uk.expediamail.com subject:"final\ details"}
  #   label 'billing & banking/travel'
  #   never_spam
  # }.otherwise {
  #   has %w{from:Expedia@uk.expediamail.com}
  #   label 'deletable/newsletters'
  # }
  # filter {
  #   has %w{from:info@mail.hotels.com subject:confirmation}
  #   label 'billing & banking/travel'
  #   never_spam
  # }.otherwise {
  #   has %w{from:info@mail.hotels.com subject:"final\ details"}
  #   label 'billing & banking/travel'
  #   never_spam
  # }.otherwise {
  #   has %w{from:info@mail.hotels.com}
  #   label 'deletable/newsletters'
  # }

end

puts fs.generate
