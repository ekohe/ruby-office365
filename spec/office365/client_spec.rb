# frozen_string_literal: true

RSpec.describe Office365::Client do
  let(:client) do
    Office365::REST::Client.new do |config|
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

    expect(response.size).to eq(3)
  end

  it "returns my mailbox messages" do
    response = VCR.use_cassette("office365_my_mailbox") { client.messages }

    expect(response.size).to eq(10)
  end

  it "returns my mailbox messages createdDateTime before 2022" do
    response = VCR.use_cassette("office365_my_mailbox_filter_by_created_date_time") { client.messages({ filter: "createdDateTime lt 2022-01-01" }) }

    expect(response.map(&:created_date_time)).to eq(["2017-12-15T09:56:50Z", "2018-03-21T20:08:12Z", "2019-07-16T08:47:06Z"])
  end

  it "returns my contacts" do
    response = VCR.use_cassette("office365_my_contact") { client.contacts }

    expect(response.size).to eq(4)
  end

  it "returns my mailbox messages with nextlink" do
    response = VCR.use_cassette("office365_my_mailbox") { client.messages_with_nextlink }

    expect(response[:next_link]).to eq("https://graph.microsoft.com/v1.0/me/messages?%24top=10&%24skip=10")
    expect(response[:results].size).to eq(10)
  end
end
