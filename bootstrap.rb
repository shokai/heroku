require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'json'

[:helpers, :controllers].each do |dir|
  Dir.glob(File.dirname(__FILE__)+"/#{dir}/*.rb").each do |rb|
    puts "loading #{rb}"
    require rb
  end
end

set :haml, :escape_html => true
