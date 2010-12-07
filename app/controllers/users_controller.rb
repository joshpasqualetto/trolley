class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_admin!
  before_filter :find_user, :only => [ :show, :edit, :update, :destroy ]

  def index
    @users = User.paginate(:per_page => 25, :page => params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(users_path, :notice => "User successfully created")
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    @user.attributes = params[:user]
    if @user.save
      redirect_to(users_path, :notice => "User successfully update")
    else
      render(:edit)
    end
  end

  def destroy
    @user.destroy
    redirect_to(users_path, :notice => "User succesully deleted")
  end

private

  def find_user
    @user = User.find(params[:id])
  end
end
