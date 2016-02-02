class Message < ActiveRecord::Base
  # Remember to create a migration!

    validates :message, length: {
      minimum: 3 }

    belongs_to :sender, class_name: "User", foreign_key: :sender_id

    belongs_to :parent_message, class_name: "Message", foreign_key: :parent_id

    has_many :children_messages, class_name: "Message", foreign_key: :parent_id

    has_one :recipient, through: :parent_message, source: :sender


end
