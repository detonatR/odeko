module Types
  module Analytics
    # GraphQL Type for Day
    class DayType < Types::BaseObject
      description "GraphQL Type for Streak"

      field :name, String, null: false, description: "The name of the Day."

      def name
        Date::DAYNAMES[object.day.to_i]
      end
    end
  end
end
