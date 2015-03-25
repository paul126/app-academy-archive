require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      req.cookies.each do |cookie|
        @cook_hash = JSON.parse(cookie.value) if cookie.name == '_rails_lite_app'
      end
        @cook_hash ||= {}
    end

    def [](key)
      @cook_hash[key]
    end

    def []=(key, val)
      @cook_hash[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cook_hash.to_json)
    end
  end
end
