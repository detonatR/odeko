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

  describe "scopes" do
    context ".streaks" do
      subject(:streaks) { Like.streaks }

      let!(:like1) { create(:like, created_at: Time.zone.local(2015, 3, 2, 1, 0, 0)) }

      let!(:like2) { create(:like, created_at: Time.zone.local(2015, 3, 5, 1, 0, 0)) }
      let!(:like3) { create(:like, created_at: Time.zone.local(2015, 3, 5, 1, 0, 0)) }

      let!(:like4) { create(:like, created_at: Time.zone.local(2015, 3, 6, 1, 0, 0)) }
      let!(:like5) { create(:like, created_at: Time.zone.local(2015, 3, 6, 1, 0, 0)) }
      let!(:like6) { create(:like, created_at: Time.zone.local(2015, 3, 6, 1, 0, 0)) }

      let!(:like7) { create(:like, created_at: Time.zone.local(2015, 3, 9, 1, 0, 0)) }
      let!(:like8) { create(:like, created_at: Time.zone.local(2015, 3, 9, 1, 0, 0)) }


      it 'returns correct streaks' do
        expect(streaks.count).to eq(1)
        expect(streaks.first.start_at.to_date).to eq(Date.parse('2015-03-02'))
        expect(streaks.first.end_at.to_date).to eq(Date.parse('2015-03-06'))
      end
    end

    context ".most_liked_days" do
      subject(:days) { Like.most_liked_days }

      let!(:like1) { create(:like, created_at: Time.zone.local(2015, 1, 1, 1, 0, 0)) }
      let!(:like2) { create(:like, created_at: Time.zone.local(2015, 1, 1, 1, 0, 0)) }

      let!(:like3) { create(:like, created_at: Time.zone.local(2015, 1, 2, 1, 0, 0)) }
      let!(:like4) { create(:like, created_at: Time.zone.local(2015, 1, 2, 1, 0, 0)) }

      let!(:like5) { create(:like, created_at: Time.zone.local(2015, 1, 3, 1, 0, 0)) }

      it "returns the correct days" do
        expect(days.count).to eq(2)
        expect(days.first.day.to_i).to eq 4
        expect(days.second.day.to_i).to eq 5
      end
    end
  end

  describe "factories" do
    it "has a valid factory" do
      record = build_stubbed(:like)
      expect(record).to be_valid
    end
  end
end
