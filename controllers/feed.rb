# -*- coding: utf-8 -*-

get '/feed/akizuki.rss' do
  content_type 'application/xml'
  @title = "秋月電子通商 新着商品"
  items = Akizuki.get_items 200

  rss = RSS::Maker.make('2.0') do |rss|
    rss.channel.about = "#{app_root}#{env['PATH_INFO']}"
    rss.channel.title = @title
    rss.channel.link = Akizuki.list_url
    rss.channel.description = @title
    items.each do |a|
      i = rss.items.new_item
      i.title = a[:title]
      i.link = a[:url]
      i.description = a[:imgs].empty? ? '' : "<p><img src=\"#{a[:imgs][0]}\" /></p>\n" +
        a[:text].map{|t| "<p>#{t}</p>" }.join("\n") +
        a[:imgs][1..-1].map{|img| "<p><img src=\"#{img}\" /></p>"}.join("\n")
    end
  end
  rss.to_s
end
