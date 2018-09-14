class TravelSafe::Country

attr_accessor :name, :country_url, :info_url, :advisory_level, :advisory_info, :passport_validity, :blank_passport_pages, :tourist_visa, :vaccinations, :currency_restrictions_entry, :currency_restrictions_exit, :embassy_address, :embassy_phone, :emergency_phone, :embassy_email, :embassy_website

@@all = []

  def initialize(name,advisory_level,country_url)
    @name = name
    @advisory_level = advisory_level
    @country_url = country_url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_all
    countries = []
    @@all.each  do |instance|
      #instances with name Worldwide Caution are not real countries
      if instance.name == "Worldwide Caution"
      else
      countries << instance.name
      end
    end
    countries.sort.each.with_index(1) do |country, i|
        puts "#{i}. #{country}"
      end
      countries = []
  end

  def self.find_by_name(input)
    @@all.detect {|instance| instance.name.upcase == input.upcase}
  end

  def self.search_by_name(input)
    possible = @@all.index{|instance| instance.name.upcase.include?(input.upcase)}
  end

  def self.more_info(country)
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    puts "Travel Advisory:".colorize(:green) + " #{country.advisory_level}"
    puts "Passport validity:".colorize(:green) + " #{country.passport_validity}"
    puts "Blank Passport Pages:".colorize(:green) + " #{country.blank_passport_pages}"
    puts "Tourist Visa Required:".colorize(:green) + " #{country.tourist_visa}"
    puts "Vaccinations:".colorize(:green) + "  #{country.vaccinations}"
    puts "Currency Restrictions for Entry:".colorize(:green) + " #{country.currency_restrictions_entry}"
    puts "Currency Restrictions for Exit:".colorize(:green) + " #{country.currency_restrictions_exit}"
    puts "Embassy Address:".colorize(:green) + " #{country.embassy_address}"
    puts "Embassy Phone:".colorize(:green) + " #{country.embassy_phone}"
    puts "Embassy Email:".colorize(:green) + " #{country.embassy_email}"
    puts "Embassy website:".colorize(:green) + " #{country.embassy_website}"
    puts "Embassy Emergency Number:".colorize(:green) + " #{country.emergency_phone}"
    puts "For more information please visit the webiste below:".colorize(:green)
    puts "#{country.country_url}"
  end

#methods test_links and test_link are used to test if links are working and identify/skip them if they aren't
  def self.test_links
    countries = []
    bad_links = []
    @@all.each  do |instance|
      countries << instance.info_url
    end
      countries.each do |url|
        begin
          doc = open(url)
        rescue
          puts "The request for a page at #{url} timed out...skipping."
          bad_links << url
          url = nil
          next
        end
      end
      if bad_links.count > 0
        puts "An error has occurred with the link(s) above."
      else
      end
  end

  def self.test_link(instance)
    url = instance.info_url
      begin
        doc = open(url)
      rescue
        puts "An error has occurred with the link below:".colorize(:red)
        puts "#{url}"
        puts "Please try again later.".colorize(:red)
        url = nil
      end
      url
  end



end
