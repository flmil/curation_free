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

@key

get '/' do
	erb :index
end

get '/more' do
	erb :index
end

post '/search' do
	p @key = params[:word].chomp.gsub(/( )/,"+")
	if @key == ""
		erb :not_words
	else
		p @page_number = 1
		@view_rakuten = rakuten
		@view_mercari = mercari
		@view_fril = fril
		unless  @view_rakuten == nil && @view_mercari == nil && @view_fril == nil
			@all_hash = tmpHash(@view_rakuten, @view_mercari, @view_fril)
			erb :result
		else
			erb :not_words
		end
	end
end


post '/more' do
	p @key = params[:word]
	p page_number = params[:pages].to_i + 1
	@page_number = page_number
	@view_rakuten_2 = more_rakuten(page_number)
	@view_mercari_2 = more_mercari(page_number)
	@view_fril_2 = more_fril(page_number)
	unless  @view_rakuten_2 == nil && @view_mercari_2 == nil && @view_fril_2 == nil
		@all_hash = tmpHash(@view_rakuten_2, @view_mercari_2, @view_fril_2)
		erb :result
	else
		erb :not_words
	end
end
