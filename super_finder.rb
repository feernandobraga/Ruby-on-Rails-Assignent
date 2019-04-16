require 'search_in_file'

class SuperFinder

  def print_banner                    # just a method that prints a simple banner
                                      # with a title and my name
    40.times {print"*"}
    puts "\n\n"
    puts "\tBIT246 - Assessment 2"
    puts "\t   Fernando Braga"
    puts "\n"
    40.times {print"*"}
    puts "\n\n\n"

  end

  def set_path(mainPath)              # first, this method stores the entered path inside @mainPath, and then
                                      # it check if the path exists. If it does, it changes the program
    @mainPath = mainPath              # directory to the entered path, otherwise it will return false
                                      # if the path doesn't exist.
    if File.exist?(@mainPath)
      Dir.chdir(@mainPath)
    else
      puts "The path is invalid"
      return false
    end

  end

  def set_query(userQuery)            # stores the entered sentence at @mainQuery
    @mainQuery = userQuery
  end

  def fetchTerm(mainPath, userQuery)
    documentsFound = SearchInFile.search(mainPath,userQuery)

    # @files = Dir.glob("**/*.txt")                     # @files will store every .txt file in the directory
    # @files.each do |file|                             # and then it will be looped through, so @currentDocument
    #   @currentDocument = File.read(file)              # can read every one of them and compare to the query.
    #   if @currentDocument =~ /#{@mainQuery}/          # If the sentence is found within the document, the hash
    #     documentsFound[file] = File.readlines(file)   # called documentsFound will store the document name
    #   end                                             # as key, and its content(in a form an array of lines)
    # end                                               # as the value.



    if documentsFound.empty?          #if the hash is empty, it means that no matches were made
      puts "\nSorry, this text doesn't exist in my library!"
    else                              #otherwise, it will print some of the document's content
      puts "\nI've found #{documentsFound.length} occurrences for \"#{userQuery}\" on:\n\n"

      documentsFound.each do |returnedHash|
        puts "\nfile: #{returnedHash[:file]}"
        @occurrence = 0

        #scans the paragraphs to find out the number of occurrences for the sentence.
        returnedHash[:paragraphs].each do |eachLine|
          @occurrence = @occurrence + eachLine.scan(/#{userQuery}/).count
        end

        #prints the value stored on paragraphs and the number of occurrences for the sentence.
        puts "Content: #{returnedHash[:paragraphs][0]}"
        puts "- The sentence appeared #{@occurrence} time(s) in this file"

      end #end each returnedHash

    end #if

  end #end fetchTerm

end #end SuperFinder Class


userSearch = SuperFinder.new         # creates the main object userSearch

userSearch.print_banner              # calls the method that prints the banner

puts "Please enter a term or a phrase to search:"   # prompt the user to enter a path and stores it
userQuery = STDIN.gets.downcase.chomp!

puts "\nNow please enter a valid path:"             # prompt the user to enter a path and stores it
mainPath = STDIN.gets.downcase.chomp!

userSearch.set_query(userQuery)                     # calls the setter method
validPath = userSearch.set_path(mainPath)           # if the path is incorrect, validPath will be false


userSearch.fetchTerm(mainPath,userQuery) if validPath    # if the valid path is true, it will run the method that fetches the term
