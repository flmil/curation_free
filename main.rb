require 'bundler/setup'
Bundler.require
require 'capybara/poltergeist'
require 'capybara-screenshot'
require 'net/http'
require "nokogiri"
require "open-uri"
require "uri"



def getslisturl(html, enc, tabs)
	doc = Nokogiri::HTML.parse(html, enc)
	result = []
	doc.css(tabs).each do |node|
		result.push(node.attribute("href").to_s)
	end
	result.flatten!
	return result
end



def getsurl_c(url, tabs)
	puts "Capybara"
	Capybara.register_driver :poltergeist do |app|
		Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 100 })
	end
	session = Capybara::Session.new(:poltergeist)
	session.visit URI.escape(url)
	return getslisturl(session.html, session.html.encoding.to_s, tabs)
end



def getsurl(url, tabs)
	puts "Nokogiri"
	enc = "utf-8"
	uri = URI.escape(url)
	doc = Nokogiri::HTML(open(uri),nil,"utf-8")
	return getslisturl(doc.inner_html, enc, tabs)
end
