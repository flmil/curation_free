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
	"hellowrld"
	erb :index
end

post '/search' do
	p @key = params[:word].chomp.gsub(/( )/,"+")
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


post '/more_3' do
	p @key = params[:word]
	page_number = 3
	@view_rakuten_3 = more_rakuten(page_number)
	@view_mercari_3 = more_mercari(page_number)
	@view_fril_3 = fril_3
	unless  @view_rakuten_3 == nil && @view_mercari_3 == nil && @view_fril_3 == nil
		@all_hash_3 = tmpHash(@view_rakuten_3, @view_mercari_3, @view_fril_3)
		erb :reslt
	else
		erb :not_words
	end
end


post '/more_4' do
	p @key = params[:word]
	@view_rakuten_4 = rakuten_4
	@view_mercari_4 = mercari_4
	@view_fril_4 = fril_4
	unless  @view_rakuten_4 == nil && @view_mercari_4 == nil && @view_fril_4 == nil
		@all_hash_4 = tmpHash(@view_rakuten_4, @view_mercari_4, @view_fril_4)
		erb :more_4
	else
		erb :not_words
	end
end

post '/more_5' do
	p @key = params[:word]
	@view_rakuten_5 = rakuten_5
	@view_mercari_5 = mercari_5
	@view_fril_5 = fril_5
	unless  @view_rakuten_5 == nil && @view_mercari_5 == nil && @view_fril_5 == nil
		@all_hash_5 = tmpHash(@view_rakuten_5, @view_mercari_5, @view_fril_5)
		erb :more_5
	else
		erb :not_words
	end
end
