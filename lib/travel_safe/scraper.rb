require 'open-uri'
require 'nokogiri'
require 'pry'

class TravelSafe::Scraper

  def self.scrape_page(url)
    binding.pry
    website = Nokogiri::HTML(open(url))
      website.css("").each do |result|
        result.css("").each do |country|
          TravelSafe::Country.new(country)
          country.css("").each do |country_url|
            country.country_url = country_url
        end
      end
  end

  def self.scrape_country(country)
    country_website = Nokogiri::HTML(open(country.country_url))
    country.advisory_level =
    country.advisory_info =
    country.tourist_visa =
    country.vaccinations =
    country.currency_restrictions_entry =
    country.currency_restrictions_exit =
    country.embassy_address =
    country.embassy_phone =
    country.emergency_phone =
  end

end
