require 'rails_helper'
require 'csv'

RSpec.describe Friendface::Importer, type: :service do
  let(:filename) { "tmp/test.csv" }
  let(:headers) { [] }
  let(:row_1) { [] }
  let(:row_2) { [] }

  let(:rows) { [headers, row_1, row_2] }

  let!(:csv) do
    CSV.open(filename, "w", headers: true) do |csv|
      rows.each do |row|
        csv << row.split(",")
      end
    end
  end

  let(:importer) { Friendface::Importer.new(filename) }

  after(:each) { File.delete(filename) } # could just use a temp file and have that auto close

  describe "import!" do
    subject(:import!) { importer.import! }

    context "when the csv is valid" do
      let(:created_at) { Time.zone.local(2015, 01, 01, 01, 00) }

      let(:row_1) { "1,kevin,2015-01-01T01:00:00.000Z" }
      let(:row_2) { "2,smith,2015-01-01T01:00:00.000Z" }

      let(:expected_result) do
        [
          an_object_having_attributes(ffid: "1", user: "kevin", post_id: 1, created_at: created_at),
          an_object_having_attributes(ffid: "2", user: "smith", post_id: 2, created_at: created_at),
        ]
      end

      it "creates the appropriate number of records" do
        expect { import! }.to change(Like, :count).by(2)
      end

      it "creates with the correct attributes" do
        import!
        expect(Like.all).to match_array(expected_result)
      end
    end

    context "when the csv is NOT valid" do
      let(:row_1) { "1,,2015-01-01T01:00:00.000Z" }

      it "returns errors" do
        expect(import!).to eq ["User can't be blank"]
      end
    end
  end
end