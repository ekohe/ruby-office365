# Office365 Library Changelog

## [0.1.0] - (2022-10-19)

- Project setup and push to rubugems

## [0.1.1] - (2022-10-21)

- Integrate REST API to get data from Graph API
  - get profile `client.me`
  - get mailbox `client.messages`
  - get calenders `client.calenders`

## [0.1.2] - (2022-10-21)

- Integrate REST API to get mailbox with pagination
  - get mailbox data with next link `client.messages({next_link: 'xxx'})`
  - get calenders data with next link `client.calenders({next_link: 'xxx'})`

## [0.1.3] - (2022-10-26)

- Integrate REST API to get contacts
  - get contacts `client.contacts`
  - get contacts data with next link `client.contacts({next_link: 'xxx'})`

## [0.1.5] - (2022-10-27)

- Generate URLs for token and able to refresh token
  - get authorize URL `client.authorize_url`
  - get token URL `client.token_url`
  - be able to refresh token `client.refresh_token!`

## [0.1.6] - (2022-11-01)

- Integrate REST API to get events
  - get events `client.events`
  - get events data with next link `client.events({next_link: 'xxx'})`

## [0.1.7] - (2022-11-11)

- Improve performance: supports select and sort in REST APIs
  - get messages by select fields `client.messages({ select: %[id] })`
  - get messages by custom order `client.messages({ order: 'id asc' })`