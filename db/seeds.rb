require 'faker'

  user = User.new(
    first_name: "Michael",
    last_name: "Jackson",
    email: "abcd@gmail.com",
    )
  user.password = "12345"
  user.password_confirmation = "12345"
  user.save

  user = User.new(
    first_name: "Abe",
    last_name: "Lincoln",
    email: "abcde@gmail.com",
    )
  user.password = "12345"
  user.password_confirmation = "12345"
  user.save

  user = User.new(
    first_name: "Joe",
    last_name: "Johnson",
    email: "abcdef@gmail.com",
    )
  user.password = "12345"
  user.password_confirmation = "12345"
  user.save

  user = User.new(
    first_name: "Ken",
    last_name: "Ryu",
    email: "abcdefg@gmail.com",
    )
  user.password = "12345"
  user.password_confirmation = "12345"
  user.save

  message = Message.new(
    sender_id: 1,
    message: Faker::Hacker.say_something_smart
  )
  message.save

  message = Message.new(
    sender_id: 2,
    parent_id: 1,
    message: Faker::Hacker.say_something_smart
  )
  message.save

  message = Message.new(
    sender_id: 1,
    parent_id: 2,
    message: Faker::Hacker.say_something_smart
  )
  message.save

  message = Message.new(
    sender_id: 2,
    parent_id: 3,
    message: Faker::Hacker.say_something_smart
  )
  message.save

  message = Message.new(
    sender_id: 1,
    parent_id: 4,
    message: Faker::Hacker.say_something_smart
  )
  message.save

# 25.times do
#   message = Message.new(
#     sender_id: rand(1..4),
#     parent_id: rand(1..4),
#     message: Faker::Hacker.say_something_smart
#   )
#   message.save
# end
