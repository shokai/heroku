require 'rubygems'
require 'sinatra'

get '/' do
  'shokai'
end

get '/env' do
  content_type 'text/plain'
  @mes = ENV.keys.sort.map{|k|
    v = ENV[k]
    "#{k} = #{v}\n"
  }
end
