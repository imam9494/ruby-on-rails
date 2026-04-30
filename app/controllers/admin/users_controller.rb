class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

def user_params
  params.require(:user).permit(:name, :email, :role)
end


def index
  @q = params[:q]

  @users = User.all

  # 🔎 SEARCH
  if @q.present?
    @users = @users.where("name ILIKE ? OR email ILIKE ?", "%#{@q}%", "%#{@q}%")
  end

  # 📄 PAGINATION
  @users = @users.page(params[:page]).per(5)
end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User berhasil dibuat"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User berhasil diupdate"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User dihapus"
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to admin_users_path, alert: "User tidak ditemukan" if @user.nil?
  end

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end

  def require_admin
    redirect_to root_path, alert: "Akses ditolak!" unless current_user.admin?
  end
end
