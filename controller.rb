require 'bundler/setup'
Bundler.require

require 'sinatra/reloader' if development?
require 'sinatra'
require 'sinatra/json'

require 'capybara/poltergeist'
require 'capybara-screenshot'
require 'net/http'
require "nokogiri"
require "open-uri"
require 'uri'
require './main.rb'
require './rakuten.rb'
require './mercari.rb'


@key = "bag"

get '/' do
	"hellowrld"
	erb :index
end

post '/search' do
	p @key = params[:word].chomp.gsub(/( )/,"+")
	@view_rakuten = rakuten
	erb :result
end


