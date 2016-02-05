class Message < ActiveRecord::Base
  # Remember to create a migration!

    validates :message, length: {
      minimum: 3 }

    belongs_to :sender, class_name: "User", foreign_key: :sender_id

    belongs_to :parent_message, class_name: "Message", foreign_key: :parent_id

    has_many :children_messages, class_name: "Message", foreign_key: :parent_id

    has_one :recipient, through: :parent_message, source: :sender

    #returns array of thread(s), will include multiple threads if it is first post

    def last_child_id
      if self.children_messages.length > 0
        return self.children_messages[0].last_child_id
      else
        return self.id
      end
    end

    def return_threads
    threads = Array.new
    if self.parent_message
      thread = [self.parent_message, self]
      temp_message = self
      until temp_message.children_messages.length == 0
        temp_message = temp_message.children_messages[0]
        thread <<  temp_message
      end
      threads << thread
    else
      self.children_messages.each do |message|
        thread = [message.parent_message, message]
        temp_message = message
        until temp_message.children_messages.length == 0
          temp_message = temp_message.children_messages[0]
          thread <<  temp_message
        end
        threads << thread
      end
    end
    return threads
  end

end
