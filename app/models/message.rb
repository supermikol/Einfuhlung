class Message < ActiveRecord::Base
  # Remember to create a migration!

  validates :message, length: {
    minimum: 2 }

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

  def time_ago_in_words
    a = (Time.now-self.created_at).to_i

    case a
      when 0 then 'just now'
      when 1 then 'a second ago'
      when 2..59 then a.to_s+' seconds ago'
      when 60..119 then 'a minute ago' #120 = 2 minutes
      when 120..3540 then (a/60).to_i.to_s+' minutes ago'
      when 3541..7100 then 'an hour ago' # 3600 = 1 hour
      when 7101..82800 then ((a+99)/3600).to_i.to_s+' hours ago'
      when 82801..172000 then 'a day ago' # 86400 = 1 day
      when 172001..518400 then ((a+800)/(60*60*24)).to_i.to_s+' days ago'
      when 518400..1036800 then 'a week ago'
      else ((a+180000)/(60*60*24*7)).to_i.to_s+' weeks ago'
    end
  end

end
