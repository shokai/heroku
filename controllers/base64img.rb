get '/base64img' do
  begin
    @url = Addressable::URI.parse (params[:url] || "http://twiticon.herokuapp.com/shokai")
    @img = Base64Image.new @url
  rescue => e
    halt 500, e.to_s
  end
  haml :base64img
end
