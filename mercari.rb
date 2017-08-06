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

def mercari 
	urls = getsurl("https://www.mercari.com/jp/search/?sort_order=&keyword=#{@key}&category_root=&brand_name=&brand_id=&size_group=&price_min=&price_max=&status_on_sale=1",
									 tabs = "div.items-box-content.clearfix section.items-box a"
									)

	hs_mercari = []
	urls.each do |url|
		url
		puts "---------------------------------"
		hs_mercari.push(scrap_m(url))
	end
	hs_mercari.flatten!
	return hs_mercari

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
	naem = "入ってない"
	money = nil
	money = "入ってない"
	img = nil
	site = "mercari"

	doc = Nokogiri::HTML.parse(html, nil,"UTF-8")
	name = doc.css("h2.item-name").inner_text
	money = doc.css('span.item-price.bold').inner_text
	doc.css('div.item-photo').each do |node|#attribute('src').to_s#.attribute("value").to_s
		p node.css('img').attribute('src').to_s#value.to_s
	end

	image = "ss"
	#if name == nil || money == nil || image == nil 
		#return nil
	#end

	return {
		url: uri,
		name: name,
		money: money,
		image: image,
		site: site,
	}
end
