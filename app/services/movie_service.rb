# frozen_string_literal: true

# app/services/movie_service.rb
class MovieService < ApplicationService
  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      # require 'pry';binding.pry
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
    end
  end

  def get_url(url)
    conn.get(url)
  end

  def movie_search(search)
    json_parse(
      conn.get('/3/search/movie') do |req|
        req.params['query'] = search
      end
    )

    ## WHY DOESN'T THIS WORK
    # json_parse(
    #   get_url("/3/search/movie") do |req|
    #     req.params["query"] = search
    #   end
    # )
  end

  def movie_discover
    json_parse(get_url('/3/discover/movie?sort_by=popularity.desc'))
  end

  def movie(id)
    json_parse(get_url("/3/movie/#{id}"))
  end

  def cast(id)
    json_parse(get_url("/3/movie/#{id}/credits"))[:cast][0..9]
  end

  def reviews(id)
    json_parse(get_url("/3/movie/#{id}/reviews"))
  end
end
