class TravelSafe::Country

attr_accessor :name, :country_url, :info_url, :advisory_level, :passport_validity, :blank_passport_pages, :tourist_visa, :vaccinations, :currency_restrictions_entry, :currency_restrictions_exit, :embassy_address, :embassy_phone, :emergency_phone, :embassy_email, :embassy_website

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

  def self.find_by_name(input)
    @@all.detect {|instance| instance.name.upcase == input.upcase}
  end

  def self.search_by_name(input)
     possible = @@all.index{|instance| instance.name.upcase.include?(input.upcase)}
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
