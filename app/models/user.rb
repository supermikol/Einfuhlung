require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id

  has_many :received_messages, through: :sent_messages, source: :children_messages

  # Remember to create a migration!

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(user_info)
    user = User.find_by(email: user_info[:email])
        # puts user_info[:password] == user.password
    return user if user && user.password == user_info[:password]
  end

  #returns array with head messages
  def head_messages
    self.sent_messages.select {|message| message.head == true}
  end



end
