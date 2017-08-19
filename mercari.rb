require 'bundler/setup'
Bundler.require
require 'capybara/poltergeist'
require 'capybara-screenshot'
require 'net/http'
require "nokogiri"
require "open-uri"
require 'uri'
require './models.rb'
require './main.rb'
require './controller.rb'

def mercari 
	urls = getsurl_c("https://www.mercari.com/jp/search/?sort_order=&keyword=#{@key}&category_root=&brand_name=&brand_id=&size_group=&price_min=&price_max=&status_on_sale=1",
								 tabs = "div.items-box-content.clearfix section.items-box a"
								)

	hs_mercari = []
	urls.each do |url|
		hs_mercari.push(scrap_m(url))
	end
	hs_mercari.flatten!
	return hs_mercari

end


def more_mercari(number)
	@number = number
	urls = getsurl_c("https://www.mercari.com/jp/search/?page=#{@number}&keyword=#{@key}&sort_order=&category_root=&brand_name=&brand_id=&size_group=&price_min=&price_max=&status_on_sale=1",
								 tabs = "div.items-box-content.clearfix section.items-box a"
								)

	hs_mercari = []
	urls.each do |url|
		hs_mercari.push(scrap_m(url))
	end
	hs_mercari.flatten!
	return hs_mercari

end

=begin
def mercari_3
	urls = getsurl_c("https://www.mercari.com/jp/search/?page=3&keyword=#{@key}&sort_order=&category_root=&brand_name=&brand_id=&size_group=&price_min=&price_max=&status_on_sale=1",
								 tabs = "div.items-box-content.clearfix section.items-box a"
								)

	hs_mercari = []
	urls.each do |url|
		hs_mercari.push(scrap_m(url))
	end
	hs_mercari.flatten!
	return hs_mercari

end
=end


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
	name = doc.css('section.item-box-container h2.item-name').inner_text
	money = doc.css('div.item-price-box.text-center span.item-price.bold').inner_text
	doc.css('div.item-photo').each do |node|
		image = node.css('img.owl-lazy').attribute('data-src').to_s
	end

	if name == nil || money == nil || image == nil 
		puts "mercari error^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
		erb :not_words
		#return nil
	end

	return {
		url: uri,
		name: name,
		money: money,
		image: image,
		site: site,
	}
end
