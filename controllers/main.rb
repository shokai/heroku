before do
  @title = "shokai.heroku #{env['PATH_INFO'].gsub(/^\//, '')}"
end

get '/' do
  haml :index
end

get '/test' do
  haml :test
end

get '/env' do
  content_type 'text/plain'
  @mes = ENV.keys.sort.map{|k|
    v = ENV[k]
    "#{k} = #{v}\n"
  }
end
