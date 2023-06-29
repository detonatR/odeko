module Types
  module Models
    # GraphQL Type for Like
    class LikeType < Types::BaseObject
      description "GraphQL Type for Like"

      implements Types::NodeType

      field :post_id, ID, null: false, description: "The post of the Like."
      field :user, String, null: false, description: "The user of the Like."
      field :ffid, String, null: true, description: "The external id of the Like."
    end
  end
end
