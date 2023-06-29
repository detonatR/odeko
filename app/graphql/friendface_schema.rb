class FriendfaceSchema < GraphQL::Schema
  disable_introspection_entry_points if Rails.env.production?

  mutation(Types::MutationType)
  query(Types::QueryType)

  default_max_page_size 100
  max_depth 13

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  rescue_from(ActiveRecord::RecordNotFound) do |_err, _obj, _args, _ctx, field|
    raise GraphQL::ExecutionError, "#{field.type.unwrap.graphql_name} not found"
  end

  rescue_from(ActiveRecord::RecordInvalid) do |err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError, err.record.errors.full_messages.join(", ").to_s
  end
end
