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
    @user = User.new(
      name: params[:name], 
      email: params[:email],  
      image_name: "default_user.jpg"
    )
    # Redirect to the Users page if the @user is valid, and render the New user page if it isn't
    if @user.save
      flash[:notice] = "You have signed up successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    # Add code to save the image
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "Your account has been updated successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form

  end

  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "You have logged in successfully"
      redirect_to("/posts/index")
    else
      @error_message = "Invalid email/password..."
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have logged out successfully"
    redirect_to("/login")
  end

  
end
