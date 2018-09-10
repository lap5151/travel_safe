class TravelSafe::Scraper

  def scrape_page
    countries = []
    scrape_results = []
    website = Nokogiri::HTML(open("https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories.html"))
    website.css("div.table-data.data-date").each do |info|
      info.css("tr").each do |row|
        scrape_results << row
        end
      end
      i=1
      while i < scrape_results.count do
            url_name = scrape_results[i].css("a").attribute("href").value
            full_url = "https://travel.state.gov" + url_name
            country_name = scrape_results[i].css("a").attribute("title").value
            country = country_name.split(/.Travel Advisory$/).join
            advisory_level = scrape_results[i].css("td")[1].children.text
            instance = TravelSafe::Country.new(country,advisory_level,full_url)
            i+=1
            countries << instance
      end
      countries.count
    end

  def scrape_country(country_url = "https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/burma-travel-advisory.html")
  blocks = []
  country_website = Nokogiri::HTML(open(country_url))
  info_url = country_website.css("div.tsg-rwd-emergency-alert-text a").attribute("href").value
  safety_info = country_website.css("div.tsg-rwd-emergency-alert-text p")
  avoid = country_website.css("div.tsg-rwd-emergency-alert-text li")
  lists = avoid.css("li").text
  blocks << safety_info.css("p")[0].text
  safety_info.css("p")[1]
  info_website = Nokogiri::HTML(open(info_url))
  info_block = info_website.css("div.tsg-rwd-qf-box-data")
  passport_validity = info_block[0].text.strip
  blank_passport_pages = info_block[1].text.strip
  tourist_visa = info_block[2].text.strip
  vaccinations = info_block[3].text.strip
  currency_restrictions_entry = info_block[4].text.strip
  currency_restrictions_exit = info_block[5].text.strip
  safety_block = info_website.css("div.tsg-rwd-accordion-copy")
  #safety_and_security = safety_block[3].text.strip
    #safety_block[3].xpath("p").each do |block|
      #blocks << block.text
  #  end
  #  blocks
  #  binding.pry
  end

end
