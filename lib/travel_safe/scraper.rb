require 'open-uri'
require 'nokogiri'
require 'pry'

class TravelSafe::Scraper

  def self.scrape_page(url= "https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories.html")
    countries = []
    scrape_results = []
    website = Nokogiri::HTML(open(url))
    website.css("div.table-data.data-date").each.with_index(1) do |info, i|
        scrape_results << info.css("tr")[i]
          scrape_results.each do |row|
            url_name = row.css("a").attribute("href").value
            full_url = "https://travel.state.gov" + url_name
            country_name = row.css("a").attribute("title").value
            country = country_name.split(/.travel advisory$/)
            advisory_level = row.css("td")[1].children.text
            countries << {:country => country, :advisory_level => advisory_level, :country_url => full_url}
      end
    end
    countries
  end

  def self.scrape_country(country_url)
    #country_website = Nokogiri::HTML(open(country.country_url))

  end

end
