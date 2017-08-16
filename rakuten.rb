require 'bundler/setup'
Bundler.require
require 'capybara/poltergeist'
require 'capybara-screenshot'
require 'net/http'
require "nokogiri"
require "open-uri"
require 'uri'
require './main.rb'

class ScraperRakuten
	def crawl

  end
end
#ScraperRakuten.new.crawl

def rakuten
	urls = getsurl_c("https://rakuma.rakuten.co.jp/search/?keyword=#{@key}&selling_status=0",
									 tabs = "ul.wall__list a"
								)

	rakuma = []
	urls.each do |url|
		rakuma.push(scrap_r(url))
	end
	rakuma.flatten!
	return rakuma
end



def rakuten_2
	urls = getsurl_c("https://rakuma.rakuten.co.jp/search/?keyword=#{@key}&selling_status=0&page=2",
									 tabs = "ul.wall__list a"
								)

	rakuma = []
	urls.each do |url|
		rakuma.push(scrap_r(url))
	end
	rakuma.flatten!
	return rakuma
end

def rakuten_3
	urls = getsurl_c("https://rakuma.rakuten.co.jp/search/?keyword=#{@key}&selling_status=0&page=3",
									 tabs = "ul.wall__list a"
								)

	rakuma = []
	urls.each do |url|
		rakuma.push(scrap_r(url))
	end
	rakuma.flatten!
	return rakuma
end



def scrap_r(url)
	begin
		uri = "https:#{url}"
		html = open(uri) do |f|
			f.read
		end
	rescue => e
		return nil
	end

	name =nil
	money = nil
	img = nil
	site = "rakuma"

	doc = Nokogiri::HTML.parse(html, nil,"UTF-8")
	name = doc.css("h1.heading__title").inner_text
	money = doc.css("div.media__thumb dd.product__price__value").inner_text
	image = "https:#{doc.css('div.gallery__main img').attribute('src').value.to_s}"

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
