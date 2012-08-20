class WithoutDirectorError < StandardError ; end

class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_same_director(movie)
  
    raise WithoutDirectorError, "'#{movie.title}' has no director info" unless movie.director !=nil && movie.director.strip.length > 0 

    Movie.find_all_by_director(movie.director)
  
  end
end
