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

  def self.scrape_country(country_url = "https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/burma-travel-advisory.html")
  blocks = []
  country_website = Nokogiri::HTML(open(country_url))
  info_url = country_website.css("div.tsg-rwd-emergency-alert-text a").attribute("href").value
  safety_info = country_website.css("div.tsg-rwd-emergency-alert-text ul")
  info_website = Nokogiri::HTML(open(info_url))
  info_block = info_website.css("div.tsg-rwd-qf-box-data")
  passport_validity = info_block[0].text.strip
  blank_passport_pages = info_block[1].text.strip
  tourist_visa = info_block[2].text.strip
  vaccinations = info_block[3].text.strip
  currency_restrictions_entry = info_block[4].text.strip
  currency_restrictions_exit = info_block[5].text.strip
  safety_block = info_website.css("div.tsg-rwd-accordion-copy")
  safety_and_security = safety_block[3].text.strip
    #safety_block[3].css("p").children.each do |block|
      #blocks << block.text
  #  end
    #blocks
    binding.pry
  end

end
