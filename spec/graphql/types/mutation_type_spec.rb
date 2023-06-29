require "rails_helper"

RSpec.describe Types::MutationType do
  subject { described_class }

  it { is_expected.to have_field(:create_like).of_type("Like") }
end
