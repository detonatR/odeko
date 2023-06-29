require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "schema" do
    it {is_expected.to have_db_index([:user, :post_id]).unique }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :post_id }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:post_id) }
  end

  describe "factories" do
    it "has a valid factory" do
      record = build_stubbed(:like)
      expect(record).to be_valid
    end
  end
end
