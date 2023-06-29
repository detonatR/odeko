module Types
  # GraphQL Type for Mutation
  class MutationType < Types::BaseObject
    field :create_like, mutation: Mutations::Likes::CreateLike
  end
end
