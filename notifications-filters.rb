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

  filter {
    archive
    twitter_emails = %w{
      postmaster.twitter.com
      notify@twitter.com
      info@twitter.com
    }
    has [{:or => "from:(#{twitter_emails.join("|")})"}]
    label '.notif/twitter'
  }.also {
    label '.notif'
  }
  filter {
    has ['from:okcupid -subject:("This week\'s top matches"|"New matches") ']
    label '.notif/okcupid'
  }.also {
    label '.notif'
  }
  filter {
    has ['list:"github.com"']
    label '.notif/github'
  }.also {
    label '.notif'
  }
  filter {
    has ['from:no-reply@accounts.google.com']
    label '.notif/google'
    star
  }.also {
    label '.notif'
  }
  filter {
    has ['list:"postmates.com"']
    label '.notif/postmates'
  }.also {
    label '.notif'
  }
  filter {
    has ['from:ifttt.com']
    label '.notif/ifttt'
    archive
  }.also {
    label '.notif'
  }
  filter {
    has ['from:(coffeemeetsbagel.com) ']
    label '.notif/coffee-bagel'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:facebookmail.com}
    label '.notif/facebook'
  }.also {
    label '.notif'
  }
  filter {
    archive
    linkedin_emails = %w{
      linkedin.com
      em.linkedin.com
      e.linkedin.com
    }
    has [{:or => "from:(#{linkedin_emails.join("|")})"}]
    label '.notif/linkedin'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:foursquare.com}
    label '.notif/foursquare'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:auto-message@eventbrite.com}
    label '.notif/eventbrite'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:calendar-notification@google.com}
    label '.notif/calendar'
  }
  # filter {
  #   archive
  #   has %w{"Invitation from Google Calendar"}
  #   label '.notif/calendar'
  # }
  # filter {
  #   archive
  #   has %w{subject:"Updated Invitation"}
  #   label '.notif/calendar'
  # }
  # filter {
  #   archive
  #   has %w{filename:invite.ics}
  #   label '.notif/calendar'
  # }.also {
  #   label '.notif'
  # }
  filter {
    archive
    has %w{from:newrelic.com}
    label '.notif/newrelic'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:dropbox.com}
    label '.notif/dropbox'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:trello.com}
    label '.notif/trello'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{subject:"Change Request" from:nobody@google.com}
    label '.notif/google'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:noreply@insideicloud.icloud.com}
    label '.notif/apple'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:info@meetup.com}
    label '.notif/meetup'
  }.also {
    label '.notif'
  }
  filter {
    archive
    has %w{from:alert@pingdom.com}
    label '.alerts/pingdom'
  }.also {
    label '.alerts'
  }


end

puts fs.generate
