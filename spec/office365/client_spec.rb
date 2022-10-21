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
end
