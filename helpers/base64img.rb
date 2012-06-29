require 'net/http'
require 'uri'
require 'addressable/uri'
require 'base64'

class Base64Image
  attr_reader :base64, :content_type

  def initialize(uri)
    unless uri.kind_of? URI or uri.kind_of? Addressable::URI
      raise ArgumentError, 'argument must be instance of URI'
    end

    res = nil
    5.times do
      res = Net::HTTP.start(uri.host, uri.port).request(Net::HTTP::Get.new uri.request_uri)
      break if res.code.to_i == 200
      if res.code =~ /^3\d{2}$/ and res.header['location']
        uri = Addressable::URI.parse res.header['location']
        next
      end
      raise StandardError, "HTTP Status Error (#{res.code})"
    end

    raise StandardError, "Resource not Image (#{res.content_type})" unless res.content_type =~ /^image\/.+/

    @base64 = Base64.encode64(res.body).strip
    @content_type = res.content_type
  end

  def to_s
    "data:#{@content_type};base64,#{@base64}"
  end
end

if __FILE__ == $0
  uri = Addressable::URI.parse ARGV.empty? ? 'http://shokai.org/archive/file/08b46ddf55836dae94eb9180c95a1d91.png' : ARGV.shift

  img = Base64Image.new uri
  puts img.base64
  puts img.content_type
end
