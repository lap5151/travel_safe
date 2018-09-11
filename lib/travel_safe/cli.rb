class TravelSafe::CLI

  def call
    puts "Loading data, this will take 1-2 minutes. Please be patient..."
    TravelSafe::Scraper.new.scrape_page
    self.menu
  end

  def menu
    puts "Bon Voyage!"
    puts "Please select what you would like to do:"
    puts "1. To see an alphabetical list of countries to choose from., type 'list'"
    puts "2. To search by country name for advisory level, type 'search'"
    puts "3. To find out more infomartion about specific country, type 'more info'"
    puts "4. To quit, type 'exit'"
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
      self.menu
    else input.upcase == "EXIT"
      puts "Safe travels!"
    end
  end

  def list
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    puts "List of countries:"
    TravelSafe::Country.list_all
    #binding.pry
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
      self.menu
  end

  def search_by_name
    puts "Please enter the country name you would like more information about:"
    input = gets.strip
    countries = TravelSafe::Country.all
    result = countries.detect {|instance| instance.name == input}
      if result != nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "#{result.name}'s travel advisory level is #{result.advisory_level}"
      else result == nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        possible = countries.index{|country| country.name.include?(input)}
          if possible != nil
            puts "Did you mean #{countries[possible].name}? YES or NO "
            input = gets.strip
            puts "                                                                  "
            puts "------------------------------------------------------------------"
            puts "                                                                  "
              if input.upcase == "YES"
                puts "#{countries[possible].name}'s travel advisory level is #{countries[possible].advisory_level}"
              else
                puts "                                                                  "
                puts "------------------------------------------------------------------"
                puts "                                                                  "
                puts "There were no search results for that country name. Please see our list of countries to choose from."
              end
          else
            puts "                                                                  "
            puts "------------------------------------------------------------------"
            puts "                                                                  "
            puts "There were no search results for that country name. Please see our list of countries to choose from."
          end
        end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    self.menu
  end

  def more_info
    puts "What country would you like more information about?"
    input = gets.strip
    #countries = ["Mexico", "India"]
    countries = TravelSafe::Country.all
    result = countries.detect {|instance| instance.name == input}
      if result != nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        #puts "#{result.name} is a great country."
        #puts "#{result.advisory_info}"
        TravelSafe::Country.more_info(result)
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "There were no search results for that country name. Please see our list of countries to choose from."
    end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    self.menu
  end



end
