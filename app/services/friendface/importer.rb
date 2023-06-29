require 'csv'

module Friendface
  class Importer
    POST_ID = 0
    USER = 1
    DATETIME = 2

    def self.run(file:)
      new(file).import!
    end

    def initialize(file)
      @file = file
    end

    def import!
      write_from_csv
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.full_messages
    end

    private

    def write_from_csv
      CSV.foreach(@file, headers: true).with_index do |row, index|
        create_like!(row, index)
      end
    end

    def create_like!(row, index)
      Like.create!(
        ffid: generate_external_id(index),
        post_id: row[POST_ID],
        user: row[USER],
        created_at: row[DATETIME],
      )
    end

    # storing the external id can be done in many ways, or not at all. depends on requirements
    def generate_external_id(index)
      index + 1
    end
  end
end