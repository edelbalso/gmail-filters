apple_emails = %w{
    do_not_reply@itunes.com
    do_not_reply@apple.com
  }

defaults = {
  :never_spam => true,
  :mark_unimportant => true,
}

FilterConfig.add('.rcpt', [
  # Groceries
  { :label => 'groceries', :has => ['from:(orders@instacart.com)'] }.merge(defaults),

  # Travel
  { :label => 'travel', :has => ['from:(orders@instacart.com)'] }.merge(defaults),

  # Shopping
  { :label => 'shop', :has => ['from:(orders@instacart.com)'] }.merge(defaults),
  { :label => 'shop', :has => ['from:(moveloot.com) subject:(purchase)'] }.merge(defaults),

  # Transportation
  { :label => 'transport', :has => ['from:(@scootnetworks.com) subject:("receipt")'] }.merge(defaults),
  { :label => 'transport', :has => ['from:(receipts @uber.com)'] }.merge(defaults),
  { :label => 'transport', :has => ['from:(supportsf@uber.com) subject:(receipt)'] }.merge(defaults),
  { :label => 'transport', :has => ['from:(no-reply@lyftmail.com "receipt")'] }.merge(defaults),
  { :label => 'transport', :has => ['from:(no-reply@lyftmail.com) subject:("receipt")'] }.merge(defaults),

  # Software Tools
  { :label => 'software',  :has => ["from:(support@github.com)", 'subject:("[GitHub] Payment Receipt")'] }.merge(defaults),
  { :label => 'software',  :has => ["from:(billing@xero.com)"] }.merge(defaults),
  { :label => 'software',  :has => ["from:(info@put.io) subject:(receipt)"] }.merge(defaults),

  # Hosting
  { :label => 'hosting',   :has => ["from:(billing@dreamhost.com)"] }.merge(defaults),

  # Expensable
  { :label => 'business',  :has => ["from:(@gogoair.com) subject:(receipt|purchase)"] }.merge(defaults),

  # food
  { :label => 'food',      :has => ["from:(no-reply@postmates.com) subject:(receipt|delivery from complete)"] }.merge(defaults),

  # square
  { :label => 'square',    :has => ['from:(messaging.squareup.com) subject:(receipt)'] }.merge(defaults),

  # Misc
  { :label => 'misc',      :has => [{:or => "from:(#{apple_emails.join("|")})"}, 'subject:(receipt)'] }.merge(defaults),
  { :label => 'misc',      :has => ['from:(service@paypal.com) subject:(Your payment)'] }.merge(defaults),
  { :label => 'misc',      :has => ['from(@google.com) subject:(receipt)'] }.merge(defaults),
  { :label => 'misc',      :has => ['from:(venmo@venmo.com) +subject:(paid|completed)'] }.merge(defaults),

])

# .each do |filter_config|
#   filter {
#     has filter_config[:has]
#     # label filter_config[:cat]
#     never_spam
#     mark_unimportant
#     archive if filter_config[:archive]
#   }.also {
#     label filter_config[:grp]
#   }.also {
#     label '.rcpt'
#   }
# end
