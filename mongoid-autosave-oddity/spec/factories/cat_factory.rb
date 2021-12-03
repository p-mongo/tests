FactoryBot.define do
  factory :cat do
    name { Faker::Creature::Cat.name }
  end
end
