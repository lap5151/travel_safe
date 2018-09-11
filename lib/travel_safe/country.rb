class TravelSafe::Country

attr_accessor :name, :country_url, :info_url, :advisory_level, :advisory_info, :passport_validity, :blank_passport_pages, :tourist_visa, :vaccinations, :currency_restrictions_entry, :currency_restrictions_exit, :embassy_address, :embassy_phone, :emergency_phone

@@all = []

  def initialize(name,advisory_level,country_url,info_url)
    @name = name
    @advisory_level = advisory_level
    @country_url = country_url
    @info_url = info_url
    #TravelSafe::Scraper.scrape_country(country_url)
  #  @passport_validity = passport_validity
  #  @blank_passport_pages = blank_passport_pages
  #  @tourist_visa = tourist_visa
  #  @vaccinations = vaccinations
  #  @currency_restrictions_entry = currency_restrictions_entry
  #  @currency_restrictions_exit = currency_restrictions_exit
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_all
    countries = []
    @@all.each  do |instance|
      countries << instance.info_url
    end
    countries.sort.each.with_index(1) do |country, i|
        puts "#{i}. #{country}"
      end
      countries = []
  end

  def self.more_info
    puts "Passport validity: #{@passport_validity}"
  end

end
