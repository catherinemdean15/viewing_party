class PartiesController < ApplicationController
  def new; end

  def create
    Movie.find_or_create_by(id: session[:movie_id],
                            title: session[:movie_title],
                            run_time: session[:movie_run_time])
    if party_params[:date].to_date >= Time.zone.today
      create_party
    else
      flash[:notice] = 'Party date must not be in the past'
      render :new, action: @party
    end
  end

  def create_party
    @party = Party.new(party_params)
    if @party.save
      flash[:notice] = 'You have made a new party!'
      redirect_to dashboard_user_path(current_user)
      PartiesUser.create!(party_id: @party.id, user_id: current_user.id, host: true)
      invite_guests if params['User']
      send_emails
    else
      flash[:notice] = 'Please complete all forms'
      render :new, action: @party
    end
  end

  def invite_guests
    invited_user_ids = params['User'].select { |_key, value| value == '1' }
    invited_user_ids.each do |user_id, _value|
      PartiesUser.create!(party_id: @party.id, user_id: user_id, host: false)
    end
  end
  
  private

  def send_emails
    UserMailer.party_host_email(@party).deliver_now
    UserMailer.party_guests_email(@party).deliver_now
  end

  def party_params
    party_info = params.require(:party).permit(:date, :start_time, :duration)
    party_info[:movie_id] = session[:movie_id]
    party_info
  end

  def confirmation_email
    @guests if params['User']
  end
end
