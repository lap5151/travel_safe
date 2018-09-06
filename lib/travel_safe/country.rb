class TravelSafe::Country

attr_accessor :name, :country_url, :advisory_level, :advisory_info, :tourist_visa, :vaccinations, :currency_restrictions_entry, :currency_restrictions_exit, :embassy_address, :embassy_phone, :emergency_phone

@@all = []

  def self.list
    country_1 = self.new
    country_1.name = "Mexico"
    country_1.country_url = "https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/mexico-travel-advisory.html"
    country_2 = self.new
    country_2.name = "India"
    country_2.country_url = "https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/india-travel-advisory.html"
    array = [country_1, country_2]
  end



end
