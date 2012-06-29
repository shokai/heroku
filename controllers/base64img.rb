get '/base64img' do
  begin
    halt 400, 'bad request' if params[:url] =~ /^#{app_root}/
    @url = Addressable::URI.parse (params[:url] || "http://twiticon.herokuapp.com/shokai")
    @img = Base64Image.new @url
  rescue => e
    halt 500, e.to_s
  end
  haml :base64img
end
