require "rails_helper"

RSpec.describe Types::Models::LikeType do
  subject { described_class }

  it_behaves_like "a NodeType"

  it { is_expected.to have_field(:post_id).of_type("ID!") }
  it { is_expected.to have_field(:user).of_type("String!") }
  it { is_expected.to have_field(:ffid).of_type("String") }
end
