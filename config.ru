require 'rubygems'
require 'bundler'
Bundler.setup(:default)
require './console'
require './server'
run Sinatra::Application
