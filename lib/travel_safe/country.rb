class TravelSafe::Country

attr_accessor :name, :country_url, :info_url, :advisory_level, :advisory_info, :passport_validity, :blank_passport_pages, :tourist_visa, :vaccinations, :currency_restrictions_entry, :currency_restrictions_exit, :embassy_address, :embassy_phone, :emergency_phone

@@all = []

  def initialize(name,advisory_level,country_url,info_url)
    @name = name
    @advisory_level = advisory_level
    @country_url = country_url
    @info_url = info_url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_all
    countries = []
    @@all.each  do |instance|
      countries << instance.name
    end
    countries.sort.each.with_index(1) do |country, i|
        puts "#{i}. #{country}"
      end
      countries = []
  end

  def self.more_info(country)
    puts "Passport validity: #{country.passport_validity}"
    puts "Blank Passport Pages: #{country.blank_passport_pages}"
    puts "Tourist Visa Required: #{country.tourist_visa}"
    puts "Vaccinations: #{country.vaccinations}"
    puts "Currency Restrictions for Entry: #{country.currency_restrictions_entry}"
    puts "Currency Restrictions for Exit: #{country.currency_restrictions_exit}"
    puts "For more information please visit the webiste below: "
    puts "#{country.country_url}"
  end

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
          next
        end
      end
      bad_links
  end


end
