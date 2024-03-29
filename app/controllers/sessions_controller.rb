class SessionsController < ApplicationController

  def new
  	if signed_in?
  	@user=current_user
  	@micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
