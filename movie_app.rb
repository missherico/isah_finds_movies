require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

# class Movie
#     attr_accessor :title, :year, :id

#     def initialize(new_title="", new_year="", new_id="")
#       @title = new_title
#       @year = new_year
#       @id = new_id
#     end
# end

get '/' do 


  erb :index
	
end


post '/results' do
  # this post will post all of the movies with those parameters
  search_str = params[:movie]

  response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => search_str})
  result = JSON.parse(response.body)
  
    #movie_array works because "Search is inherently an array, that houses hashes of movies"
    #comparator - write custom sort function, make comparator,
    # if item on left to be first -1, right +1, equal 0  <=>
    
  @movie_array = result["Search"].sort_by { |movie| movie["Year"]}.select { |movie| movie["Type"] == "movie"}



  erb :result

end


get '/movie/:imdb' do
  id = params[:imdb]

  response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => id, :plot => "full"})
  
  @movie = JSON.parse(response.body)
   # result is a hash of all the attributes of one movie

 

  erb :movie

end








