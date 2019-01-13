class User < ApplicationRecord
  include Clearance::User
  # has_many :messages
  has_and_belongs_to_many :chatrooms # starred chatrooms
  has_many :notifications

  def confirm_email
    self.email_confirmed_at = Time.current
    save
  end

  def set_nickname(nickname)
    self.nickname = nickname
  end

  def get_nickname
    return self.nickname
  end

  def get_starred_chatrooms
    return self.chatrooms
  end
end
