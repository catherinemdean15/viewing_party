class PartiesController < ApplicationController
  def new; end

  def create
    Movie.find_or_create_by(movie_params)
    create_party
  end

  def create_party
    @party = Party.new(party_params)
    if @party.save
      flash[:notice] = 'You have made a new party!'
      redirect_to dashboard_user_path(current_user)
      invite_guests
    else
      flash[:notice] = 'Please complete all forms'
      render :new, action: @party
    end
  end

  def invite_guests
    PartiesUser.create!(party_id: @party.id, user_id: current_user.id, host: true)
    if params['User']
      invited_user_ids = params['User'].select { |_key, value| value == '1' }
      invited_user_ids.each do |user_id, _value|
        PartiesUser.create!(party_id: @party.id, user_id: user_id, host: false)
      end
    end
  end

  private

  def party_params
    params.require(:party).permit(:date, :start_time, :duration, :movie_id)
  end

  def movie_params
    movie_params = params.require(:party).permit(:movie_id, :movie_title, :movie_run_time)
    movie_params[:id] = movie_params.delete(:movie_id)
    movie_params[:title] = movie_params.delete(:movie_title)
    movie_params[:run_time] = movie_params.delete(:movie_run_time)
    movie_params
  end
end
