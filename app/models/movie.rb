class Movie < ApplicationRecord
  def self.find_in_tmdb(terms, api_key = ENV['TMDB_API_KEY'])
    base_url = "https://api.themoviedb.org/3/search/movie"
    query = {
      api_key: api_key,
      query: terms[:title]
    }
    query[:year] = terms[:release_year] if terms[:release_year].present?
    query[:language] = terms[:language] if terms[:language].present? && terms[:language] != 'all'

    url = "#{base_url}?#{query.to_query}"
    response = Faraday.get(url)
    return [] unless response

    results = JSON.parse(response.body)["results"] || []
    results.map do |movie|
      Movie.new(
        title: movie["title"],
        release_date: movie["release_date"].presence,
        description: movie["overview"],
        rating: "R"
      )
    end
  end

  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end
end