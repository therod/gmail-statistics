require 'sinatra'

get '/' do
  @emails = Email.all
  erb :home, layout: :application
end
