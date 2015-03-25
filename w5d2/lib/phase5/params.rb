require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
      unless req.query_string.nil?
        query_hash = parse_www_encoded_form(req.query_string)
        @params.merge!(query_hash)
      end
      unless req.body.nil?
        body_hash = parse_www_encoded_form(req.body)
        p body_hash
        @params.merge!(body_hash)
      end

    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      p_hash = {}
      p_nest_hash = {}
      nested_hash = {}

      params_array = URI::decode_www_form(www_encoded_form)
      params_array.each do |pair|
        p_hash.merge!(pair[0] => pair[1])
      end

      p_hash.each do |key, val|
        nest_arr = parse_key(key)

        nest_arr.each_index do |idx|
          if idx == 0
            nested_hash = {nest_arr[0 - 1 - idx] => val}
          else
            nested_hash = {nest_arr[0 - 1 - idx] => nested_hash}
          end
        end
        p_nest_hash.merge!(nest_helper(p_nest_hash, nested_hash))
      end

      p_nest_hash
    end

    def nest_helper(h1, h2)
      nest_key = h2.keys[0]
      if h1.include?(nest_key)
        nest_helper(h1[nest_key], h2[nest_key])
      else
        h1.merge!(h2)
      end
    end


    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
