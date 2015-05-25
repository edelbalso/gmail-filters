
domains = %w{
  airbnb.com
  apple.com
  bandmix.com
  coursera.com
  digitalocean.com
  dropbox.com
  egghead.io
  eventbrite.com
  facebook.com
  foursquare.com
  freedomfiler.com
  github.com
  google.com
  growthhacker.tv
  heroku.com
  ifttt.com
  ilovemtl.ca
  linkedin.com
  meetup.com
  newrelic.com
  overstock.com
  pbworks.com
  postmates.com
  screenhero.com
  square.com
  thestorefront.com
  trello.com
  twitter.com
  venmo.com
  wakatime.com
}

custom_rules = [
  { :label => 'apple',       :has => ['from:insideicloud.icloud.com'] },
  { :label => 'coff-bag',    :has => ['from:(coffeemeetsbagel.com)'] },
  { :label => 'dropbox',     :has => ['from:(dropboxmail.com)'] },
  { :label => 'facebook',    :has => ['from:facebookmail.com'] },
  { :label => 'gcal',        :has => ['from:calendar-notification@google.com'] },
  { :label => 'google',      :has => ['from:@accounts.google.com'], :star => true, :archive => false },
  { :label => 'monkeybrains',:has => ['from:@monkeybrains.net'], :star => true, :archive => false },
  { :label => 'okcupid',     :has => ['from:okcupid -subject:("This week\'s top matches"|"New matches")'], :star => true },
  { :label => 'okcupid',     :has => ['from:okcupid subject:("This week\'s top matches"|"New matches")'], :archive => true },
  { :label => 'potsmates',   :has => ['list:"postmates.com"'] },
  { :label => 'steam',       :has => ['from:(steampowered.com)'] },
  { :label => 'ville-mtl',   :has => ['from:(ville.montreal.qc.ca)'] },
]

ruleset = domains.map do |dom|
  { :label => dom.split('.')[0], :has => ["from:(#{dom})"]}
end
ruleset += custom_rules

defaults = {
  :archive => true,
  :never_spam => true,
  :mark_unimportant => true,
}

# This will hopefully let custom rules override defaults:
ruleset = ruleset.map{|rule| defaults.merge(rule) }
FilterConfig.add('.notif', ruleset)
