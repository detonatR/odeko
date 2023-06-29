module Fields
  module Mutations
    module Likes
      # should just be straight modules but using concern for dsl consistency / railsy demo purposes etc
      extend ActiveSupport::Concern

      included do
        field :create_like,  mutation: ::Mutations::Likes::CreateLike,
                             description: "Mutation for a User to create a Like"
      end
    end
  end
end
