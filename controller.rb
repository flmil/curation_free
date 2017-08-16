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
	all_hash = []
	p @key = params[:word].chomp.gsub(/( )/,"+")
	@view_rakuten = rakuten
	@view_mercari = mercari
	@view_fril = fril
	unless  @view_rakuten == nil || @view_mercari == nil || @view_fril == nil
		#@all_hash = tmpHash(@view_rakuten, @view_mercari, @view_fril)
		#@all_hash = tmpHash(rakuten, mercari, fril)#上の #= をなくす
		@view_rakuten.each do |rakuten|
			all_hash.push(rakuten)
		end
		@view_mercari.each do |mercari| 
			all_hash.push(mercari)
		end
		@view_fril.each do |fril| 
			all_hash.push(fril)
		end
		@all_hash = all_hash
		erb :result
	else
		erb :not_words
	end
end


post '/more_2' do
	all_hash_2 = []
	p @key = params[:word_2]
	@view_rakuten_2 = rakuten_2
	@view_mercari_2 = mercari_2
	@view_fril_2 = fril_2
	unless  @view_rakuten_2 == nil || @view_mercari_2 == nil || @view_fril_2 == nil
		@view_rakuten_2.each do |rakuten_2|
			all_hash_2.push(rakuten_2)
		end
		@view_mercari_2.each do |mercari_2| 
			all_hash_2.push(mercari_2)
		end
		@view_fril_2.each do |fril_2| 
			all_hash_2.push(fril_2)
		end
		@all_hash_2 = all_hash_2
		erb :more_2
	else
		erb :not_words
	end
end


post '/more_3' do
	all_hash_3 = []
	p @key = params[:word_3]
	@view_rakuten_3 = rakuten_3
	@view_mercari_3 = mercari_3
	@view_fril_3 = fril_3
	unless  @view_rakuten_3 == nil || @view_mercari_3 == nil || @view_fril_3 == nil
		@view_rakuten_3.each do |rakuten_3|
			all_hash_3.push(rakuten_3)
		end
		@view_mercari_3.each do |mercari_3|
			all_hash_3.push(mercari_3)
		end
		@view_fril_3.each do |fril_3|
			all_hash_3.push(fril_3)
		end
		@all_hash_3 = all_hash_3
		erb :more_3
	else
		erb :not_words
	end
end
