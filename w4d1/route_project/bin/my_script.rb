require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users'
).to_s

begin
  puts RestClient.post(url, { user: { username: "Gizmo2"}})
rescue RestClient::Exception => e
  puts e
end
