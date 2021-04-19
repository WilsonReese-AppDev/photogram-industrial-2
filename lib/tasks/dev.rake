task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    FollowRequest.destroy_all
    Comment.destroy_all
    Like.destroy_all
    Photo.destroy_all
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
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
      
      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end
  p "#{FollowRequest.count} follow requests have been sent"

  # create a few photos
  15.times do
    users.each do |user|
      photo = user.own_photos.create(
        image: "https://robohash.org/#{Faker::Alphanumeric.alpha(number: 10)}",
        caption: "#{Faker::Movies::LordOfTheRings.character} at #{Faker::Movies::LordOfTheRings.location}"
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.likes.create(
            fan: follower
          )
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.singular_siegler,
            author: follower
          )
        end
      end
    end
  end

  p "#{Photo.count} photos have been posted."
  p "#{Like.count} likes."
  p "#{Comment.count} comments."

  # leave a few comments, likes
  

end