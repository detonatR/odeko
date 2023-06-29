FactoryBot.define do
  factory :like do
    post_id { 2 }
    sequence( :user) {|n| "example-#{n}" }
    ffid { nil }
  end
end
