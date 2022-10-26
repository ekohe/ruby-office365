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

**response**

    - `results`: wrap all data into results
    - `next_link`: get the new link for the next page of data

**to JSON**

    - `as_json`: convert office365 object to JSON format

**Get Profile (as the authenticated user)**

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

**Get my calendars**

```ruby
irb(main):005:0> client.calendars
irb(main):005:0> client.calendars[:results]
irb(main):005:0> client.calendars[:next_link]
```

**Get my mails**

```ruby
irb(main):005:0> client.messages
irb(main):005:0> client.messages[:results]
irb(main):005:0> client.messages({ filter: "createdDateTime lt 2022-01-01" })
irb(main):005:0> client.messages({ filter: "createdDateTime lt 2022-01-01", next_link: 'https://....' })
```

**Get my contacts**

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

**Refresh User Token**

```ruby
irb(main):005:0> client.refresh_token!
```

## Copyright

Copyright (c) 2022 Encore Shao. See LICENSE for details.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/ruby-office365.
