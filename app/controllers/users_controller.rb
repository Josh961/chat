class UsersController < Clearance::UsersController
  # Check this link to see what Clearance::UsersController is doing
  # https://github.com/thoughtbot/clearance/blob/master/app/controllers/clearance/users_controller.rb
  #
  # Probably shouldn't override those methods, but instead make new ones to do what we want to do
  # The methods from that link handle all the user stuff... login, authentication, restricting pages, etc.

  def new
    @user = user_from_params
    puts "USER #{@user}"
    session[:user] = @user
    render template: "users/new"
  end

  def edit
    @chatroom = Chatroom.new
    @user = current_user
  end

  def create
    @user = user_from_params
    @user.email_confirmation_token = Clearance::Token.new
    if @user.save
      ClearanceMailer.registration_confirmation(@user).deliver_later
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
    session[:user] = @user
  end

  def update
    @user = current_user
    @user.update(user_params_edit)
    puts @user.errors.messages
    redirect_to profile_path
  end

  def get_nickname
    return @user.get_nickname
  end

  # Sets the user's nickname to be whatever they pass in
  # Throws an error if it could not save
  def set_nickname
    @user.set_nickname(params.require(:nickname))
    unless @user.save
      flash.now[:error] = "Could not update nickname"
    end
  end

  def get_starred_chatrooms
    return @user.get_starred_chatrooms
  end

  # Sets the user's chatrooms to be whatever they pass in
  # Throws an error if it could not save
  def set_starred_chatrooms
    user = User.find_by(id: params.require(:user))
    room = Chatroom.find_by(id: params.require(:room))
    if room.users.find_by(id: user.id).nil?
      user.chatrooms << room
      room.number_of_stars += 1
    else
      user.chatrooms.delete(room)
      room.number_of_stars -= 1
    end
    # room.users << user
    unless user.save && room.save
      flash.now[:error] = "Could not set chatrooms"
    end
    redirect_to "/index"
  end

  # Sets the user's permissions to be whatever they pass in
  # Throws an error if it could not save
  def set_user_permissions
    @user.permissions = params.require(:permissions)
    unless @user.save
      flash.now[:error] = "Could not update permissions"
    end
  end

  def user_from_params
    email = user_params.delete(:email)
    nickname = user_params.delete(:nickname)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.nickname = nickname
      user.password = password
      user.permissions = false
    end
  end

  private
  def user_params_edit
    params.require(:user).permit(:nickname, :password).reject { |k, v| v.blank? }
  end
end
