class TravelSafe::CLI

  def call
    puts "Loading data, this will take less than a minute. Please be patient...".colorize(:red)
    TravelSafe::Scraper.new.scrape_page
    puts "                                                                  "
    puts "Welcome!".colorize(:cyan)
    puts "                                                                  "
    self.menu
  end

  def menu
    puts "Please select what you would like to do:".colorize(:cyan)
    puts "1. To see an alphabetical list of countries to choose from, type".colorize(:magenta) + " 'list'".colorize(:yellow)
    puts "2. To search by country name for advisory level, type".colorize(:magenta) + " 'search'".colorize(:yellow)
    puts "3. To find out more travel infomartion about specific country, type".colorize(:magenta) + " 'more info'".colorize(:yellow)
    puts "4. To quit, type".colorize(:magenta) + " 'exit'".colorize(:red)
    input = gets.strip
    if input.upcase == "LIST"
      self.list
    elsif input.upcase == "SEARCH"
      self.search_by_name
    elsif input.upcase == "MORE INFO"
      self.more_info
    elsif input.upcase != "EXIT"
      puts "                                                                  "
      puts "Sorry, I don't recognize that command.".colorize(:red)
      puts "                                                                  "
      self.menu
    else input.upcase == "EXIT"
      puts "Bon Voyage!".colorize(:cyan)
    end
  end

  def list
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    puts "List of countries:".colorize(:green)
    TravelSafe::Country.list_all
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
      self.menu
  end

  def search_by_name
    puts "Please enter the country name you would like more information about:".colorize(:yellow)
    answer = gets.strip
    instance = TravelSafe::Country.find_by_name(answer)
      if instance != nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "#{instance.name}'s travel advisory level is #{instance.advisory_level}".colorize(:green)
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        self.did_you_mean_search?(answer)
      end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    self.menu
  end

  def more_info
    puts "What country would you like more travel information about?".colorize(:yellow)
    answer = gets.strip
    result = TravelSafe::Country.find_by_name(answer)
      if result != nil
        TravelSafe::Scraper.scrape_country(result)
        TravelSafe::Country.more_info(result)
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        self.did_you_mean_info?(answer)
      end
      puts "                                                                  "
      puts "------------------------------------------------------------------"
      puts "                                                                  "
      self.menu
  end

  def did_you_mean_search?(answer)
    possible = TravelSafe::Country.search_by_name(answer)
    countries = TravelSafe::Country.all
    if possible != nil
      puts "Did you mean #{countries[possible].name}? YES or NO ".colorize(:yellow)
      input = gets.strip
      puts "                                                                  "
      puts "------------------------------------------------------------------"
      puts "                                                                  "
        if input.upcase == "YES"
          puts "#{countries[possible].name}'s travel advisory level is #{countries[possible].advisory_level}".colorize(:green)
        elsif input.upcase != "YES" && input.upcase != "NO"
          self.did_you_mean_search?(answer)
        else
          puts "                                                                  "
          puts "------------------------------------------------------------------"
          puts "                                                                  "
          puts "There were no search results for that country name. Please see our list of countries to choose from.".colorize(:red)
        end
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "There were no search results for that country name. Please see our list of countries to choose from.".colorize(:red)
      end
  end

  def did_you_mean_info?(answer)
    possible = TravelSafe::Country.search_by_name(answer)
    countries = TravelSafe::Country.all
    if possible != nil
      puts "Did you mean #{countries[possible].name}? YES or NO ".colorize(:yellow)
      input = gets.strip
      puts "                                                                  "
      puts "------------------------------------------------------------------"
      puts "                                                                  "
        if input.upcase == "YES"
          TravelSafe::Scraper.scrape_country(countries[possible])
          TravelSafe::Country.more_info(countries[possible])
        elsif input.upcase != "YES" && input.upcase != "NO"
          self.did_you_mean_info?(answer)
        else
          puts "                                                                  "
          puts "------------------------------------------------------------------"
          puts "                                                                  "
          puts "There were no search results for that country name. Please see our list of countries to choose from.".colorize(:red)
        end
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "There were no search results for that country name. Please see our list of countries to choose from.".colorize(:red)
      end
  end


end
