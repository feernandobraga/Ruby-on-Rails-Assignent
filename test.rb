require 'search_in_file'

mainpath = '/users/fernando/ebooks'
query = "level"

resultSet =  SearchInFile.search(mainpath, query)
puts resultSet