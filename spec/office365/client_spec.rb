# frozen_string_literal: true

RSpec.describe Office365::Client do
  let(:client) do
    Office365::REST::Client.new do |config|
      config.tenant_id = "12345"
      config.access_token = "token"
    end
  end

  it "returns my profile" do
    response = VCR.use_cassette("office365_my_profile") { client.me }

    expect(response.display_name).to eq("Andy vBox")
    expect(response.surname).to eq("Andy")
    expect(response.given_name).to eq("vBox")
  end

  it "returns my calendars" do
    response = VCR.use_cassette("office365_my_calendars") { client.calendars }

    expect(response[:results].size).to eq(3)
  end

  it "returns my events in calendar" do
    response = VCR.use_cassette("office365_my_events") { client.events }

    expect(response[:results].size).to eq(1)
  end

  it "returns my events for the next week" do
    response = VCR.use_cassette("office365_my_events_for_the_next_week") do
      client.events({ startdatetime: "2024-11-14T00:00:00.000Z", enddatetime: "2024-11-21T00:00:00.000Z" })
    end

    expect(response[:results].size).to eq(3)
  end

  it "returns my mailbox messages" do
    response = VCR.use_cassette("office365_my_mailbox") { client.messages }

    expect(response[:results].size).to eq(10)
  end

  it "returns my mailbox messages with next_link" do
    response = VCR.use_cassette("office365_my_mailbox_with_next_link") do
      client.messages({ next_link: "https://graph.microsoft.com/v1.0/me/messages?%24top=10&%24skip=10" })
    end

    expect(response[:next_link]).to eq("https://graph.microsoft.com/v1.0/me/messages?%24top=10&%24skip=20")
    expect(response[:results].size).to eq(10)
  end

  it "returns my mailbox messages createdDateTime before 2022" do
    response = VCR.use_cassette("office365_my_mailbox_filter_by_created_date_time") do
      client.messages({ filter: "createdDateTime lt 2022-01-01" })
    end

    expect(response[:results].size).to eq(0)
  end

  it "returns my mailbox messages before 2022-10-01" do
    response = VCR.use_cassette("office365_my_mailbox_before_2022-10-01") do
      client.messages({ filter: "createdDateTime lt 2022-10-01" })
    end

    expect(response[:results].size).to eq(10)
    expect(response[:results].map(&:created_date_time)).to eq(["2022-05-25T15:10:48Z",
                                                               "2022-05-25T15:41:54Z",
                                                               "2022-05-25T15:42:17Z",
                                                               "2022-05-25T15:59:04Z",
                                                               "2022-05-27T11:37:33Z",
                                                               "2022-05-27T15:05:06Z",
                                                               "2022-05-29T13:17:52Z",
                                                               "2022-06-01T10:06:31Z",
                                                               "2022-06-02T15:01:38Z",
                                                               "2022-06-06T02:20:14Z"])
  end

  it "returns my contacts" do
    response = VCR.use_cassette("office365_my_contacts") { client.contacts }

    expect(response[:results].size).to eq(1)
  end

  it "returns authorize URL" do
    expect(client.authorize_url).to include("https://login.microsoftonline.com/12345/oauth2/v2.0/authorize")
  end

  it "returns token URL" do
    expect(client.token_url).to eq("https://login.microsoftonline.com/12345/oauth2/v2.0/token")
  end

  it "returns event by id" do
    response = VCR.use_cassette("office365_event_by_id") { client.event("identifier") }

    expect(response[:results].size).to eq(1)
  end

  it "creates subscription" do
    args = {
      changeType: "updated,deleted",
      notificationUrl: "https://hello-world.com/office365/notifications",
      lifecycleNotificationUrl: "https://hello-world.com/office365/lifecycle_notifications",
      resource: "/me/events",
      expirationDateTime: "2024-08-07T12:00:00.0000000Z",
      clientState: "SecretClientState"
    }

    response = VCR.use_cassette("office365_create_subscription") { client.create_subscription(args) }

    expect(response.class).to eq(Office365::Models::Subscription)
    expect(response.resource).to eq(args[:resource])
    expect(response.change_type).to eq(args[:changeType])
    expect(response.id).to eq("subscription-identifier")
  end

  it "renew subscription" do
    args = {
      identifier: "subscription-identifier",
      expirationDateTime: "2024-08-08T12:00:00.0000000Z"
    }

    response = VCR.use_cassette("office365_renew_subscription") { client.renew_subscription(args) }

    expect(response.class).to eq(Office365::Models::Subscription)
    expect(response.resource).to eq("/me/events")
    expect(response.change_type).to eq("updated,deleted")
    expect(response.expiration_date_time).to eq("2024-08-08T12:00:00Z")
    expect(response.id).to eq("subscription-identifier")
  end

  xit "be able to refresh token by refresh_token" do
    expect(client.refresh_token!).to eq({})
  end
end
