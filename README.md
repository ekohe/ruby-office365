# Office 365 (2024) <img src="https://i.ibb.co/g3mpswn/microsoft-office-365-logo-2016-100727915-large.webp" align="right" width="250" height="150">
A simple ruby library to interact with Microsoft Graph **[Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)** and Office 365 API

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ruby-office365

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ruby-office365

## Features

- Supports user's mailboxes, calendars, contacts, events
- Supports refresh token

## Configuration

You can pass configuration options as a block to `Office365::REST::Client.new`.

- tenant_id: optional, only required for refresh_token
- client_id: optional, only required for refresh_token
- client_secret: optional, only required for refresh_token
- access_token: required for fetch mailbox, calendars, contacts data
- refresh_token: optional, only required for refresh_token
- debug: optional, default false, output the request information

### Used to get data from MS Graph API

```ruby
client = Office365::REST::Client.new do |config|
  config.access_token = "YOUR_ACCESS_TOKEN"
  config.debug = "true/false" # Optional, default to false, output the information in the request
end
```

### For refresh token

```ruby
client = Office365::REST::Client.new do |config|
  config.tenant_id = "YOUR_ORG_TENANT_ID"
  config.client_id = "YOUR_APP_CLIENT_ID"
  config.client_secret = "YOUR_APP_CLIENT_SECRET"
  config.refresh_token = "YOUR_REFRESH_TOKEN"
  config.debug = "true/false" # Optional, default to false, output the information in the request
end
```

## Usage

After configuring a `client`, you can do the following things.

**Response structure**

    - results: wrap all data into results
    - next_link: get the new link for the next page of data

**A simple way to convert an office365 object to JSON**

    - as_json: convert office365 object to JSON format

**Get my profile by access token**

```ruby
irb(main):004:0> response = client.me
irb(main):010:0> response.display_name
=> "Hello World"
irb(main):004:0> response.as_json
=> {
    :odata_context=>"https://graph.microsoft.com/v1.0/$metadata#users/$entity",
    :display_name=>"Hello World",
    :surname=>"Hello",
    :given_name=>"World",
    :id=>"d7e954e0b50095ad",
    :user_principal_name=>"hello.world@mail.com",
    :business_phones=>[],
    :job_title=>nil,
    :mail=>nil,
    :mobile_phone=>nil,
    :office_location=>nil,
    :preferred_language=>nil
}
```

**Get my calendars by access token**

```ruby
irb(main):005:0> client.calendars
irb(main):005:0> client.calendars[:results]
irb(main):005:0> client.calendars[:next_link]
```

**Get my events by access token**

```ruby
irb(main):005:0> client.events
irb(main):005:0> client.events[:results]
irb(main):005:0> client.events[:next_link]
```

**Get my event by id**

```ruby
irb(main):005:0> client.event('identifier')
irb(main):005:0> client.event('identifier')[:results]
```

Results will return an array even if it is a single result.  

**Get my mails by access token**

```ruby
irb(main):005:0> client.messages
irb(main):005:0> client.messages[:results]
irb(main):005:0> client.messages({ filter: "createdDateTime lt 2022-01-01" })
irb(main):005:0> client.messages({ filter: "createdDateTime lt 2022-01-01", next_link: 'https://....' })
```

**Get my contacts by access token**

```ruby
irb(main):018:0> response = client.contacts
irb(main):020:0> client.contacts[:results][0].display_name
=> "Encore S."
irb(main):018:0> response[:results][0].as_json
=> {
    :odata_etag=>"W/\"EQAAABYAAACbUc86NQthQ7+Mvj19ecwVAABjabQj\"",
    :id=>"AQMkADAwATM3ZmYAZS00ZTU5LWY3NwBjLTAwAi0wMAoARgAAA4QFHqPHk4JJj7ZVaRPCKk4HAJtRzzo1C2FDv4y_PX15zBUAAAIBDgAAAJtRzzo1C2FDv4y_PX15zBUAAABja1I_AAAA",
    :created_date_time=>"2022-10-24T02:48:56Z",
    :last_modified_date_time=>"2022-10-24T02:48:57Z",
    :change_key=>"EQAAABYAAACbUc86NQthQ7+Mvj19ecwVAABjabQj",
    :categories=>[],
    :parent_folder_id=>"AQMkADAwATM3ZmYAZS00ZTU5LWY3NwBjLTAwAi0wMAoALgAAA4QFHqPHk4JJj7ZVaRPCKk4BAJtRzzo1C2FDv4y_PX15zBUAAAIBDgAAAA==",
    :birthday=>nil,
    :file_as=>"",
    :display_name=>"Name S.",
    :given_name=>"Name",
    :initials=>nil,
    :middle_name=>nil,
    :nick_name=>nil,
    :surname=>"S.",
    :title=>nil,
    :yomi_given_name=>nil,
    :yomi_surname=>nil,
    :yomi_company_name=>"",
    :generation=>nil,
    :im_addresses=>[],
    :job_title=>"",
    :company_name=>nil,
    :department=>"",
    :office_location=>"",
    :profession=>nil,
    :business_home_page=>"",
    :assistant_name=>"",
    :manager=>"",
    :home_phones=>[],
    :mobile_phone=>"",
    :business_phones=>[],
    :spouse_name=>"",
    :personal_notes=>"",
    :children=>[],
    :email_addresses=>[{"name"=>"name@google.com", "address"=>"name@google.com"}],
    :home_address=>{},
    :business_address=>{},
    :other_address=>{}
}
```

**Refresh access token by refresh token**

```ruby
irb(main):005:0> response = client.refresh_token!
irb(main):005:0> response.scope
=> "openid User.Read profile email"
irb(main):005:0> response.access_token
=> "eyJ0eXAiOiJKV1QiLCJub25jZSI6ImFDYUladFJ6M3RSc3dFaktxUHdGbF9kVlFmbjJabG85Mjlkb2xaeFBhZm8iLCJhbGciOiJSUzI1NiIsIng1dCI6IjJaUXBKM1VwYmpBWVhZR2FYRUpsOGxWMFRPSSIsImtpZCI6IjJaUXBKM1VwYmpBWVhZR2FYRUpsOGxWMFRPSSJ9..."
irb(main):005:0> response.refresh_token
=> "0.ARgA7EiQdLv1qECnFqPfrznKsT9ERYaGfG9Ki5WzQtEllj8YAJk.AgABAAEAAAD--DLA3VO7QrddgJg7WevrAgDs_wQA9P-Q1ODlBsrdZi-5s2mfLtEsavBgiEhGcz1KEf26fMrGFU3LM_og5l6wjSAtQ83XHLuje0_KYGol26_LGV_uH0F1MwCFR1N3ctwg4_...."
```

**Create Subscription: it will create a webhook for Office365**

```ruby
args = {
  changeType: "updated,deleted",
  notificationUrl: "https://hello-world.com/office365/notifications",
  lifecycleNotificationUrl: "https://hello-world.com/office365/lifecycle_notifications",
  resource: "/me/{type}",
  expirationDateTime: "2024-08-07T12:00:00.0000000Z",
  clientState: "SecretClientState"
}

irb(main):005:0> subscription = client.create_subscription(args)
```

will return the subscription object `Office365::Models::Subscription`

**Renew Subscription**

```ruby
args = {
  identifier: "subscription-identifier",
  expirationDateTime: "2024-08-08T12:00:00.0000000Z"
}

irb(main):005:0> subscription = client.renew_subscription(args)
```

will return the subscription object `Office365::Models::Subscription`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Copyright

Copyright (c) 2022 Encore Shao. See LICENSE for details.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/ruby-office365.
