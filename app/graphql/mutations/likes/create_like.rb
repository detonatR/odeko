module Mutations
  module Likes
    class CreateLike < Mutations::BaseMutation
      description "Mutation for a User to create a Like"

      type Types::Models::LikeType

      argument :post_id, ID, required: true, description: "ID of Post"

      def resolve(post_id:)
        record = Like.new(post_id: post_id, user: context[:current_user])
        do_something(record)
        record
      end

      private

      def do_something(record)
        record.save!
      end
    end
  end
end