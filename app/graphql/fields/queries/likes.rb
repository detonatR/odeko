module Fields
  module Queries
    # Query for Likes Fields
    module Likes
      extend ActiveSupport::Concern

      included do
        field :streaks, [Types::Analytics::StreakType], null: false, description: "LIST streaks of days with more likes than previous day."
        field :most_liked_days, [Types::Analytics::DayType], null: false, description: "LIST days with most likes."
      end

      def streaks
        Analytics::StreakReporter.run
      end

      def most_liked_days
        Analytics::PopularDayReporter.run
      end
    end
  end
end
