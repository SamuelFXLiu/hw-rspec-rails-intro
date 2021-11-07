class Movie < ActiveRecord::Base
    def self.all_ratings
      ['G', 'PG', 'PG-13', 'R']
    end
    
    def self.with_ratings(ratings, sort_by)
      if ratings.nil?
        all.order sort_by
      else
        where(rating: ratings.map(&:upcase)).order sort_by
      end
    end
  
    def self.find_in_tmdb(hash, key = "b900578a7c3d2aa2358f719064a6f0c0")
      k = {api_key: key}
      k[:query] = hash[:title]
      k[:year] = hash[:release_year]
      k[:language] = hash[:language]
      puts(k)
      response = JSON.parse(Faraday.get('https://api.themoviedb.org/3/search/movie',
        k).body)
    end
  
end
  