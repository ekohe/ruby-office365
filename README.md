# Office 365

A simple ruby library to interact with Microsoft Graph and Office 365 API.

- https://developer.microsoft.com/en-us/graph/graph-explorer

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ruby-office365

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ruby-office365

## Configuration

You can pass configuration options as a block to `Office365::REST::Client.new`.

```ruby
client = Office365::REST::Client.new do |config|
  config.tenant_id          = "YOUR_ORG_TENANT_ID"
  config.client_id          = "YOUR_APP_CLIENT_ID"
  config.client_secret      = "YOUR_APP_CLIENT_SECRET"
  config.redirect_uri       = "YOUR_APP_REDIRECT_URL"
  config.access_token       = "YOUR_ACCESS_TOKEN"
  config.refresh_token      = "YOUR_REFRESH_TOKEN"
end
```

## Usage Examples

After configuring a `client`, you can do the following things.

**Get Profile (as the authenticated user)**

```ruby
client.me
```

**Get all calendars**

```ruby
client.calendars
```

**Get all mailbox**

```ruby
client.messages
client.messages({ filter: "createdDateTime lt 2022-01-01" })
client.messages_with_nextlink
client.messages_with_nextlink(next_link: true, params: { filter: "createdDateTime lt 2022-01-01" })
```

**Get all contact**

```ruby
client.contacts
```

## Copyright

Copyright (c) 2022 Encore Shao. See LICENSE for details.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/ruby-office365.
