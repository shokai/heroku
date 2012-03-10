require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require File.dirname(__FILE__)+'/bootstrap'

set :environment, :development

run Sinatra::Application
