def update
  @user = User.find(params[:id])

  if @user.update(user_params)
    redirect_to admin_users_path, notice: "User berhasil diupdate"
  else
    render :edit
  end
end
