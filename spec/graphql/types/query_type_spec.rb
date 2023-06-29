require "rails_helper"

RSpec.describe Types::QueryType do
  subject(:query_type) { described_class }

  it { is_expected.to have_field(:streaks).of_type("[Streak!]!") }
  it { is_expected.to have_field(:most_liked_days).of_type("[Day!]!") }
end
