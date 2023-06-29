require "rails_helper"

RSpec.describe Types::Analytics::StreakType do
  subject { described_class }

  it { is_expected.to have_field(:start_at).of_type("ISO8601DateTime!") }
  it { is_expected.to have_field(:end_at).of_type("ISO8601DateTime!") }
end
