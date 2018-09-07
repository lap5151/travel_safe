require 'open-uri'
require 'nokogiri'
require 'pry'

class TravelSafe::Scraper

  def self.scrape_page(url= "https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories.html")
    countries = []
    website = Nokogiri::HTML(open(url))
    website.css("div.table-data.data-date").each do |info|
        #info.css("tr").children.each do |row|
          info.css("tr").children each do |row|
            url_name = row.css("a").attribute("href").value
            full_url = "https://travel.state.gov" + url_name
            country_name = row.css("a").attribute("title").value
          #row.css("td").children do |result|
        #name = result.css("td")[0]
        #country = name.split(/.travel advisory$/)
        #advisory_level = result.css("td")[1].text
        #url = result.css("td a").attribute("href").text
      #  country_url = "https://travel.state.gov" + url
        #TravelSafe::Country.new(name,advisory_level,country_url)
        #countries << name
                      binding.pry
            #TravelSafe::Country.new(country)
        #  country.css("").each do |country_url|
        #    country.country_url = country_url
            #binding.pry
            #self.scrape_country(country_url)
        #end
      end
    end
  end

  def self.scrape_country(country_url)
    #country_website = Nokogiri::HTML(open(country.country_url))

  end

end
