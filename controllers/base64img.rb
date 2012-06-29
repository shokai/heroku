get '/base64img' do
  begin
    stop_request_pattern = /^https?:\/\/#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}/
    halt 400, 'bad request' if params[:url] =~ stop_request_pattern
    @url = Addressable::URI.parse (params[:url] || "http://twiticon.herokuapp.com/shokai")
    @img = Base64Image.new @url, stop_request_pattern
  rescue => e
    halt 500, e.to_s
  end
  haml :base64img
end
