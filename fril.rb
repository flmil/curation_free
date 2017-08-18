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
	urls = getsurl_c("https://fril.jp/search/#{@key}?transaction=selling",
									 tabs = "div.item-box__text-wrapper a.link_search_title"
								)

	hs_fril = []
	urls.each do |url|
		hs_fril.push(scrap_f(url))
	end
	hs_fril.flatten!
	return hs_fril

end

def more_fril(number)
	@number = number
	urls = getsurl_c("https://fril.jp/search/#{@key}/page/#{@number}?order=desc&sort=relevance&transaction=selling",
									 tabs = "div.item-box__text-wrapper a.link_search_title"
								)

	hs_fril = []
	urls.each do |url|
		hs_fril.push(scrap_f(url))
	end
	hs_fril.flatten!
	return hs_fril

end

=begin
def fril_3
	urls = getsurl_c("https://fril.jp/search/#{@key}/page/3?order=desc&sort=relevance&transaction=selling",
									 tabs = "div.item-box__text-wrapper a.link_search_title"
								)

	hs_fril = []
	urls.each do |url|
		hs_fril.push(scrap_f(url))
	end
	hs_fril.flatten!
	return hs_fril

end
=end



#ScraperRakuten.new.crawl

def scrap_f(url)
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
	site = "fril"

	doc = Nokogiri::HTML.parse(html, nil,"UTF-8")
	name = doc.css('div.item-info__header h1.item__name').inner_text
	money = doc.css('div.item-info__header p.item__value_area span.item__value').inner_text

	image = doc.css('img.sp-image').attribute('src').to_s
=begin
	doc.css('img.sp-image').each do |node|
		image = node.attribute('src').to_s
	end
	doc.css('div.photoFrame').each do |node|
		p node 
		p image = node.css('img.sp-image').attribute('src').to_s
		p image = node.css('img.sp-image').attribute('data-default').to_s
	end
=end
	if name == nil || money == nil || image == nil 
		puts "fril error^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
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
