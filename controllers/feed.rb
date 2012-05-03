# -*- coding: utf-8 -*-

get '/feed/akizuki.rss' do
  content_type 'application/xml'
  @title = "秋月電子通商 新着商品"
  rss = RSS::Maker.make('2.0') do |rss|
    rss.channel.about = "#{app_root}#{env['PATH_INFO']}"
    rss.channel.title = @title
    rss.channel.link = Akizuki.list_url
    rss.channel.description = @title
    Akizuki.get_items(20).each do |a|
      i = rss.items.new_item
      i.title = a[:title]
      i.link = a[:url]
      i.description = a[:text].map{|t| "<p>#{t}</p>"}.join("\n") +
        a[:imgs].map{|img| "<img src=\"#{img}\" />"}.join("\n")
    end
  end
  rss.to_s
end
