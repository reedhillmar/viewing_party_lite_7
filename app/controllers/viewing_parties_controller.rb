# frozen_string_literal: false

# app/controllers/viewing_parties_controller.rb
class ViewingPartiesController < ApplicationController
  def new
    # require 'pry';binding.pry
    if session[:user_id]
      @movie = MoviesFacade.new(params[:id]).movie
      @users = User.where.not(id: session[:user_id])
    else
      flash[:alert] = "You must be registered and logged in to create a viewing party."
      redirect_to movie_path(params[:id])
    end
  end

  def create
    @movie = MoviesFacade.new(params[:movie_id]).movie
    party = ViewingParty.create(date_time: param_datetime_formatter,
                                movie_id: params[:movie_id],
                                duration: params[:duration])
    if params[:duration].to_i < @movie.runtime
      # redirect_to "/users/#{:user_id}/movies/#{:movie_id}/viewing_parties/new"
      redirect_to new_viewing_party_path(params[:movie_id])
      flash[:alert] = 'Error: Duration must not be less than movie runtime'
    elsif party.save
      create_host_viewing_party(party)
      create_invited_viewing_party(party)
      redirect_to "/dashboard"
    else
      # redirect_to "/users/#{:user_id}/movies/#{:movie_id}/viewing_parties/new"
      redirect_to new_viewing_party_path(params[:movie_id])
      flash[:alert] = "Error: #{error_message(party.errors)}"
    end
  end

  private

  def create_host_viewing_party(party)
    UserViewingParty.create!(viewing_party: party, user_id: session[:user_id], host: true)
  end
  
  def create_invited_viewing_party(party)
    unless params[:invites_id].nil?
      params[:invites_id].each do |invite_id|
        UserViewingParty.create!(viewing_party: party, user_id: invite_id)
      end 
    end
  end

  # def viewing_params
  #   date_time: param_datetime_formatter,
  #   movie_id: params[:movie_id],
  #   duration: params[:duration]
  # end
  
  def param_datetime_formatter # "2023-04-27 14:54:09 UTC"
    ""  <<  params["date(1i)"] << "-" <<
            params["date(2i)"] << "-" <<
            params["date(3i)"] << " " <<
            params["time(4i)"] << ":" <<
            params["time(5i)"] << ":" <<
            "00" << " " <<
            "UTC"
  end
end