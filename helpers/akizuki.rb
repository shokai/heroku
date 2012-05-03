# -*- coding: utf-8 -*-
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'kconv'

class Akizuki
  def self.base_url
    'http://akizukidenshi.com'
  end
  
  def self.list_url
    "#{base_url}/catalog/e/enewall_dT/"
  end

  def self.get_items(limit=20)
    doc = Nokogiri::HTML open(list_url).read
    doc.xpath('//a').to_a.delete_if{|a|
      a['href'] !~ /^\/catalog\/g\/[a-zA-Z0-9\-]+/
    }.map{|a|
      {:title => a.text.strip, :url => "#{base_url}#{a['href']}"}
    }[0...limit].map{|i|
      begin
        res = get_item i[:url]
        res[:url] = i[:url]
      rescue => e
        STDERR.puts e
        res = nil
      end
      res
    }.delete_if{|i|
      !(i.kind_of? Hash)
    }
  end

  def self.get_item(url)
    code = url.scan(/\/g([A-Z0-9\-]+)\/?$/).first.first
    doc = Nokogiri::HTML open(url).read

    title = doc.xpath('//title').text
    body = doc.xpath('//table[@class="cart_table"]')
    text = body.xpath('//td').map{|td|
      td.text.toutf8
    }.delete_if{|td|
      td !~ /#{code}/
    }.first.split(/[\t\r\n]+/).delete_if{|i|
      i.size < 1
    }
    imgs = body.xpath('//img').map{|i|
      "#{base_url}#{i['src']}"
    }.uniq.delete_if{|i|
      i !~ /\/goods\// or i =~ /\/goods\/S\//
    }

    { :text => text, :imgs => imgs, :title => title }
  end
end


if __FILE__ == $0
  require 'pp'
  Akizuki.get_items(5).each{|i|
    pp i
  }
end
