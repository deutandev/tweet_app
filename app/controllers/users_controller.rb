class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    # Declare the @user variable and assign it the a new instance of User
    @user = User.new
  end
  
  def create
    @user = User.new(name: params[:name], email: params[:email])
    # Redirect to the Users page if the @user is valid, and render the New user page if it isn't
    if @user.save
      flash[:notice] = "You have signed up successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end
  
end
