require 'sinatra'

get '/' do
  "hello #{ENV['USERNAME']}"
end
