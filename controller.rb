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
require "pry"

require './main.rb'
require './rakuten.rb'
require './fril.rb'
require './mercari.rb'


# binding.pry

@key = "bag"

get '/' do
	"hellowrld"
	erb :index
end

post '/search' do
	p @key = params[:word].chomp.gsub(/( )/,"+")
	p @view_rakuten = rakuten
	p @view_mercari = mercari
	erb :result
end


