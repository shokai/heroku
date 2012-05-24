require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
$stdout.sync = true if development?
require File.dirname(__FILE__)+'/bootstrap'

run Sinatra::Application
