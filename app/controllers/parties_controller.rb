class PartiesController < ApplicationController
  def new; end

  def create
    create_movie unless Movie.exists?(params[:party][:movie_id])
    create_party
  end

  def create_party
    @party = Party.new(party_params)
    @party.update(movie_id: params[:party][:movie_id])
    if @party.save
      flash[:notice] = 'You have made a new party!'
      redirect_to dashboard_user_path(current_user)
      invite_guests
    else
      flash[:notice] = 'Please complete all forms'
      render :new, action: @party
    end
  end

  def create_movie
    Movie.create!(id: params[:party][:movie_id],
                  title: params[:party][:movie_title],
                  run_time: params[:party][:movie_run_time])
  end

  def invite_guests
    PartiesUser.create!(party_id: @party.id, user_id: current_user.id, host: true)
    invited_user_ids = params['User'].select { |_key, value| value == '1' }
    invited_user_ids.each do |user_id, _value|
      PartiesUser.create!(party_id: @party.id, user_id: user_id, host: false)
    end
  end

  private

  def party_params
    params.require(:party).permit(:date, :start_time, :duration)
  end
end
