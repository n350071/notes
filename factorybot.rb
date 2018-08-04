FactoryBot.define do
  factory :child do
    sequence(:name){|i| "name_#{i}"}

    association :parent
  end
end
