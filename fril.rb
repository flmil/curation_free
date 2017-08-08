require 'bundler/setup'
Bundler.require
require 'capybara/poltergeist'
require 'capybara-screenshot'
require 'net/http'
require "nokogiri"
require "open-uri"
require 'uri'
require './main.rb'
require './controller.rb'

def fril
	urls = getsurl("https://fril.jp/search/#{@key}?transaction=selling",
								 tabs = "div.item-box__item-namer a"
								)

	hs_fril = []
	urls.each do |url|
		hs_fril.push(scrap_m(url))
	end
	hs_fril.flatten!
	return hs_fril

end
#ScraperRakuten.new.crawl

def scrap_m(url)
	begin
		uri = url
		html = open(uri) do |f|
			f.read
		end
	rescue => e
		return nil
	end

	name =nil
	money = nil
	image = nil
	site = "mercari"

	doc = Nokogiri::HTML.parse(html, nil,"UTF-8")
	name = doc.css('div.item-info__header h1.item__name').inner_text
	money = doc.css('div.item-info__header p.item__value_area span.item__value').inner_text
	doc.css('div.sp-slide sp-selected').each do |node|
		image = node.css('img.sp-image').attribute('src').to_s
	end

	if name == nil || money == nil || image == nil 
		puts "error^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
		return nil
	end

	return {
		url: uri,
		name: name,
		money: money,
		image: image,
		site: site,
	}
end
