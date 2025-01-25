# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#   Movie.create(title: "The Matrix", overview: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.", poster_url: "https://image.tmdb.org/t/p/original/dQw4w9WgXcQ", rating: 8.7)
#   List.create(name: "Science Fiction")
#   Bookmark.create(comment: "A must-see for sci-fi fans!", movie_id: 1, list_id: 1)
# end
#
#6

require 'net/http'
require 'uri'
url = "https://tmdb.lewagon.com/movie/top_rated"
fetch_url = URI.parse(url)
response = Net::HTTP.get(fetch_url)
data = JSON.parse(response)
puts data

movies = data["results"]
poster_base_url = "https://image.tmdb.org/t/p/w500"

Movie.destroy_all

movies.each do |movie|
  Movie.create(title: movie["title"], overview: movie["overview"], poster_url: "#{poster_base_url}#{movie["poster_path"]}", rating: movie["vote_average"])
end
