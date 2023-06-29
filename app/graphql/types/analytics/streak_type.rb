module Types
  module Analytics
  # GraphQL Type for Streak
    class StreakType < Types::BaseObject
      description "GraphQL Type for Streak"

      field :start_at, GraphQL::Types::ISO8601DateTime, null: false, description: "The start of the Streak."
      field :end_at, GraphQL::Types::ISO8601DateTime, null: false, description: "The end of the Streak."
    end
  end
end
