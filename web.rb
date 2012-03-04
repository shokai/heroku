require 'rubygems'
require 'sinatra'

get '/' do
  haml :index
end

get '/env' do
  content_type 'text/plain'
  @mes = ENV.keys.sort.map{|k|
    v = ENV[k]
    "#{k} = #{v}\n"
  }
end
