FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
  end

  factory :course do
    sequence :title do |n|
      "course#{n}"
    end
    email { title }
  end

  factory :admin do
    email 'admin'
    password 'admin'
    password_confirmation 'admin'
  end

  factory :lesson do
    sequence :title do |n|
      "lesson#{n}"
    end
    sequence :position do |n|
      n
    end
    course
    text { "text for #{title}" }
  end

  factory :question do
    lesson
    sequence :text do |n|
      "question#{n}"
    end
  end

  factory :answer do
    question
    correct true
    sequence :text do |n|
      "question#{n}"
    end
  end

  factory :quiz do
    lesson
    user
    secret { Quiz.generate_secret(user) }
  end
end
