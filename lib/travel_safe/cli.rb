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
      puts "What country would you like more information about?"
      input = gets.strip
      self.more_info(input.upcase)
    elsif input.upcase != "EXIT"
      self.call
    else input.upcase == "EXIT"
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
    countries = ["Mexico", "India"].sort
    countries.each_with_index do |country, i|
      puts "#{i+1}. #{country}"
    end
    puts "                                                                  "
    puts "------------------------------------------------------------------"
    puts "                                                                  "
      self.call
  end

  def search_by_name
    puts "Please enter the country name you would like more information about:"
    input = gets.strip
    countries = ["Mexico", "India"]
    result = countries.detect {|name| name.upcase == input.upcase}
      if result != nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "#{result}'s travel advisory level is level 1." #country.advisory_level, country[:advisory_level]
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

  def more_info(input)
    countries = ["Mexico", "India"]
    result = countries.detect {|name| name.upcase == input.upcase}
      if result != nil
        puts "                                                                  "
        puts "------------------------------------------------------------------"
        puts "                                                                  "
        puts "#{result} is a great country." #country.advisory_level, country[:advisory_level]
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
