class TravelSafe::CLI

  def call
    puts "Loading data, this will take about a minute. Please be patient...".colorize(:red)
    TravelSafe::Scraper.new.scrape_page
    puts "                                                                  "
    puts "Welcome!".colorize(:cyan)
    puts "                                                                  "
    menu
  end

  def menu
    puts "Please select what you would like to do:".colorize(:cyan)
    puts "1. To see an alphabetized list of countries to choose from, type".colorize(:magenta) + " 'list'".colorize(:yellow)
    puts "2. To see a list of countries with a specific advisory level, type".colorize(:magenta) + " 'advisory'".colorize(:yellow)
    puts "3. To find out more travel information about specific country, type".colorize(:magenta) + " 'search'".colorize(:yellow)
    puts "4. To quit, type".colorize(:magenta) + " 'quit'".colorize(:red)
    input = gets.strip
    if input.upcase == "LIST"
      list
    elsif input.upcase == "ADVISORY"
      list_by_advisory_level
    elsif input.upcase == "SEARCH"
      search_by_name
    elsif input.upcase != "QUIT"
      puts "                                                                  "
      puts "Sorry, I don't recognize that command.".colorize(:red)
      puts "                                                                  "
      menu
    else input.upcase == "QUIT"
      puts "Bon Voyage!".colorize(:cyan)
    end
  end

  def list
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    puts "Below are the country names you can search for:".colorize(:green)
      list_all
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
      menu
  end

  def list_by_advisory_level
    puts "Please enter the advisory level you would like to inspect:".colorize(:yellow)
    puts "To see all countries with level 1 advisories, enter".colorize(:light_magenta) + " '1'".colorize(:yellow)
    puts "To see all countries with level 2 advisories, enter".colorize(:light_magenta) + " '2'".colorize(:yellow)
    puts "To see all countries with level 3 advisories, enter".colorize(:light_magenta) + " '3'".colorize(:yellow)
    puts "To see all countries with level 4 advisories, enter".colorize(:light_magenta) + " '4'".colorize(:yellow)
    answer = gets.strip
    number = answer.to_i
      if 0 >= number || number > 4
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "I did not recognize that entry.".colorize(:red)
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        by_advisory_level(answer)
      end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
    menu
  end

  def search_by_name
    puts "Which country would you like more travel information about?".colorize(:yellow)
    answer = gets.strip
    result = TravelSafe::Country.find_by_name(answer)
      if result != nil
        TravelSafe::Scraper.scrape_country(result) if result.info_url == nil
        more_info(result)
      else
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        did_you_mean?(answer)
      end
      puts "                                                                  "
      puts "------------------------------------------------------------------"
      puts "                                                                  "
      menu
  end

  def did_you_mean?(answer)
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
          more_info(countries[possible])
        elsif input.upcase != "YES" && input.upcase != "NO"
          did_you_mean_info?(answer)
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

  def list_all
    countries = []
    TravelSafe::Country.all.each  do |instance|
      #instances with name Worldwide Caution are not real countries
      if instance.name != "Worldwide Caution"
      countries << instance.name
      end
    end
    countries.sort.each.with_index(1) do |country, i|
        puts "#{country}"
      end
  end

  def by_advisory_level(input)
    if input == "1"
      index = "Level 1: Exercise Normal Precautions"
    elsif input == "2"
      index = "Level 2: Exercise Increased Caution"
    elsif input == "3"
      index = "Level 3: Reconsider Travel"
    else input == "4"
      index = "Level 4: Do Not Travel"
    end
    countries = []
      TravelSafe::Country.all.each  do |instance|
        #instances with name Worldwide Caution are not real countries
        if instance.name != "Worldwide Caution" && instance.advisory_level == index
          countries << instance
        end
      end
      puts "The travel advisory for the following countries is #{index}".colorize(:green)
      countries.each do |country|
          puts "#{country.name}"
        end
  end

  def more_info(country)
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

end
