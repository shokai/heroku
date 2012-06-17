require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
$stdout.sync = true if development?
require 'sinatra/content_for'
require 'haml'
require 'sass'
require 'json'
require 'rss'
require 'tmp_cache'
require File.expand_path 'bootstrap', File.dirname(__FILE__)
Bootstrap.init :helpers, :controllers

set :haml, :escape_html => true

run Sinatra::Application
