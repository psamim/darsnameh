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
end
