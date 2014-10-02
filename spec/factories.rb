FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
  end

  factory :course do
    sequence :title do |n|
      "course no. #{n}"
    end
    email { title }
  end
end
