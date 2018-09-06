class TravelSafe::CLI

  def call
    puts "Bon Voyage!"
    puts "Please select what you would like to do:"
    self.menu
    input = gets.strip
    if input.upcase == "LIST"
      self.list
    elsif input.upcase == "SEARCH"
      self.search_by_name
    elsif input.upcase == "MORE INFO"
      self.more_info
    elsif input.upcase != "EXIT"
      puts "                                                                  "
      puts "Sorry, I don't recognize that command."
      puts "                                                                  "
      self.call
    else input.upcase == "EXIT"
      puts "Safe travels!"
    end
  end

  def menu
    puts "1. To see an alphabetical list of countries to choose from., type 'list'"
    puts "2. To search by country name for advisory level, type 'search'"
    puts "3. To find out more infomartion about specific country, type 'more info'"
    puts "4. To quit, type 'exit'"
  end

  def list
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    puts "List of countries:"
    #countries = ["Mexico", "India"].sort
    TravelSafe::Country.hard_coded #TravelSafe::Country.all
    countries = TravelSafe::Country.list_all
    countries.each.with_index(1) do |country, i|
      puts "#{i}. #{country}"
    end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
      self.call
  end

  def search_by_name
    puts "Please enter the country name you would like more information about:"
    input = gets.strip
    #countries = ["Mexico", "India"]
    #TravelSafe::Country.hard_coded
    countries = TravelSafe::Country.hard_coded #TravelSafe::Country.all
    result = countries.detect {|instance| instance.name == input}
      if result != nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "#{result.name}'s travel advisory level is #{result.advisory_level}" #{}", country[:advisory_level]
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "There were no search results for that country name. Please see our list of countries to choose from."
    end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    self.call
  end

  def more_info
    puts "What country would you like more information about?"
    input = gets.strip
    #countries = ["Mexico", "India"]
    countries = TravelSafe::Country.hard_coded #TravelSafe::Country.all
    result = countries.detect {|instance| instance.name == input}
      if result != nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "#{result.name} is a great country." #country.advisory_level, country[:advisory_level]
        puts "#{result.advisory_info}"
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "There were no search results for that country name. Please see our list of countries to choose from."
    end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    self.call
  end



end
