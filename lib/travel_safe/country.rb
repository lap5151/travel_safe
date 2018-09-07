class TravelSafe::Country

attr_accessor :name, :country_url, :advisory_level, :advisory_info, :tourist_visa, :vaccinations, :currency_restrictions_entry, :currency_restrictions_exit, :embassy_address, :embassy_phone, :emergency_phone

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
    list = []
    @@all.each do |country|
      list << country.name
    end
    list.sort
  end

  def self.hard_coded
    mexico = self.new("Mexico","level 1","url")
    mexico.advisory_info = "Info here."
    @@all
  end


end
