task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    FollowRequest.destroy_all
    User.destroy_all
  end

  12.times do
    user_info = { 
      email: Faker::Internet.unique.safe_email,
      password: "password",
      username: Faker::Internet.unique.username,
      private: [true, false].sample
    }
    u = User.create(user_info)
  end
  
  p "#{User.count} users have been created."

  # Have users follow each other
  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if first_user.id > second_user.id
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
      
      if first_user.id < second_user.id
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end
  p "#{FollowRequest.count} follow requests have been sent"
  # p "#{FollowRequest}"

end