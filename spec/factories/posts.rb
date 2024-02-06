FactoryBot.define do
  factory :orange, class: Post do
    name {'aaaaaa'}
    content { 'xxxxxxx' }
    created_at { 10.minutes.ago }
  end
 
  factory :most_recent, class: Post do
    name {'bbbbbbbb'}
    content { 'yyyyyyyyy' }
    created_at { Time.zone.now }
    user { association :user, email: 'recent@example.com' }
  end
end
 
def user_with_posts(posts_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:orange, posts_count, user: user)
  end
end