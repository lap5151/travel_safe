class TravelSafe::Scraper

  def scrape_page
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
            country_url = "https://travel.state.gov" + url_name
            country_name = scrape_results[i].css("a").attribute("title").value.strip
            country = country_name.split(/.Travel Advisory$/).join
            advisory_level = scrape_results[i].css("td")[1].children.text
            country_website = Nokogiri::HTML(open(country_url))
            instance = TravelSafe::Country.new(country,advisory_level,country_url)
            i+=1
      end
    end

  def self.scrape_country(instance)
  location = []
  contacts = []
  country_website = Nokogiri::HTML(open(instance.country_url))
  info_url = country_website.at_css('a:contains("country information page")')
  info_url_2 = country_website.at_css('a:contains("country information")')
  info_url_3 = country_website.at_css('a:contains("Country Information page")')
      if info_url != nil
        info_url = info_url["href"]
      elsif info_url_2 != nil
        info_url = info_url_2["href"]
      elsif info_url_3 != nil
        info_url = info_url_3["href"]
      else
        info_url = country_website.css("div.tsg-rwd-emergency-alert-text a").attribute("href").value
      end
      if info_url.strip.split("https://www.faa.gov").count == 2
        info_url = info_url.strip
      elsif info_url.strip.split("https://travel.state.gov").count == 1
        info_url = "https://travel.state.gov" + info_url.strip
      elsif info_url == "https://travel.state.gov/content/passports/en/country/south-sudan.htmll"
        info_url = "https://travel.state.gov/content/passports/en/country/south-sudan.html"
      elsif info_url == "https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/MoldovaRepublicof.html"
        info_url = "https://travel.state.gov/content/travel/en/international-travel/International-Travel-Country-Information-Pages/Moldova.html"
      else
        info_url = info_url.strip
      end
  instance.info_url = info_url
  info_url = TravelSafe::Country.test_link(instance)
  if info_url != nil
    info_website = Nokogiri::HTML(open(info_url))
    safety_block = info_website.css("div.tsg-rwd-accordion-copy")
    embassy = info_website.css("div.tsg-rwd-csi-contact-data-box-address")
    contact = info_website.css("div.tsg-rwd-csi-contact-data-box")
        contact.children.each do |contact_info|
          contacts << contact_info.text
        end
        i = 0
        until i == embassy.children.count
          location << embassy.children[i].text
          i+=1
        end
        info_block = info_website.css("div.tsg-rwd-qf-box-data")
        instance.passport_validity = info_block[0].text.strip if info_block[0] != nil
        instance.blank_passport_pages = info_block[1].text.strip if info_block[1] != nil
        instance.tourist_visa = info_block[2].text.strip if info_block[2] != nil
        instance.vaccinations = info_block[3].text.strip if info_block[3] != nil
        instance.currency_restrictions_entry = info_block[4].text.strip if info_block[4] != nil
        instance.currency_restrictions_exit = info_block[5].text.strip if info_block[5] != nil
        instance.embassy_address = location.join(" ")
        instance.embassy_phone = contacts[0] if contacts[0] != nil
        instance.emergency_phone = contacts[1] if contacts[1] != nil
        instance.embassy_email = contacts[3] if contacts[3] != nil
        instance.embassy_website = contact.children[4]["href"] if contacts[4] != nil
    else
    end
  end

end
