require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra'
require 'sinatra/json'

require 'sinatra/activerecord'
require 'capybara/poltergeist'
require 'capybara-screenshot'
require 'net/http'
require "nokogiri"
require "open-uri"
require 'uri'
require "pry"

require './models.rb'
require './models'
require './main.rb'
require './rakuten.rb'
require './fril.rb'
require './mercari.rb'
require 'sinatra/reloader' if development?

enable :sessions

helpers do
	def current_user
		User.find_by(id: session[:user])
	end
end

before '/tasks' do
	if current_user.nil?
		redirect '/'
	end
end



@key

get '/' do
	erb :index, layout: nil #, layout: :layout#:layout => !request.xhr? #, layout => false
end

#User-------------------------------------------------------------------------
get '/signup' do
	erb :sign_up
end
post '/signup' do
	user = User.create(name: params[:name],mail: params[:mail],password: params[:password],password_confirmation: params[:password_confirmation])
	if user.persisted?
		session[:user] = user.id
	end
	redirect '/'
end

get '/signin' do
	erb :sign_in
end
post '/signin' do
	user = User.find_by(mail: params[:mail])
	if user && user.authenticate(params[:password])
		session[:user] = user.id
	end
	redirect '/'
end
get '/signout' do
	session[:user] = nil
	redirect '/'
end
#User-------------------------------------------------------------------------

#lists----------------------------------------------------------------------
post '/search/add_list' do
	if !current_user.nil?
		current_user.lists.create(name: params[:name],money: params[:money],url: params[:url],site: params[:site],image: params[:image])
		redirect '/list'
	else
		redirect 'signin'
	end
end
post '/search/:url/page/add_list' do
	if !current_user.nil?
		current_user.lists.create(name: params[:name],money: params[:money],url: params[:url],site: params[:site],image: params[:image])
		redirect '/list'
	else
		redirect 'signin'
	end
end
get '/list' do
	if current_user.nil?
		@lists = List.none
	else
		@lists = current_user.lists
	end
	erb :lists
end
post '/list/:id/delete' do
	list = List.find(params[:id])
	list.destroy
	redirect '/list'
end
#lists-----------------------------------------------------------------------

get '/more' do
	erb :index, layout: nil
end
get '/search' do
	erb :index, layout: nil
end


post '/search' do
	p @key = params[:word].chomp.gsub(/( )/,"+")
	if @key == ""
		erb :not_words
	else
		redirect "/search/#{@key}"
	end
end

get '/search/:key' do
	p @key = params[:key]
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
	p @page_number = params[:pages].to_i + 1
	redirect "/search/#{@key}/page/#{@page_number}"
end

get '/search/:key/page/:page_number' do
	p @key = params[:key]
	p page_number = params[:page_number]
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
