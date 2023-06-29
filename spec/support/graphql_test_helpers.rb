# frozen_string_literal: true

# Test Helpers for GraphQl requests and mutations
# @see https://dev.to/rjrobinson/testing-graphql-ruby-mutations-with-rspec-3ngc
# Thanks RJ!
module GraphqlTestHelpers
  attr_accessor :gql_response

  # Creates an "anonymous" QueryType for more isolated Type tests
  # The stubbed QueryType is still a part of the application's GraphQL Schema and has access to Pundit policies
  # @see https://relishapp.com/rspec/rspec-rails/docs/controller-specs/anonymous-controller
  def query_type(&block)
    before(:each) do
      query_type = Class.new(Types::BaseObject) { graphql_name "QueryType" }
      query_type.instance_eval("def described_class; #{described_class} end; # def described_class; UserType end;",
                               __FILE__, __LINE__ - 1)
      query_type.class_eval(&block)

      stub_const("FriendfaceSchema", Class.new(FriendfaceSchema) { query(query_type) })
    end
  end

  # Makes it easier to see GraphQL errors in the tests
  class GraphqlException < StandardError
    def initialize(gql_response)
      super(gql_response.errors)
    end
  end

  # The returned results of a GraphQL query
  # @return [data] this is the bulk of the return to test.
  # @return [error] any time a query, mutation, subscription throws and error
  class GQLResponse
    attr_reader :data, :errors

    def initialize(args)
      @data = args["data"] || nil
      @errors = args["errors"] || nil
    end

    def errors?
      errors.present?
    end
  end

  # Execute a GraphQL query with the provided Schema
  # @param query required The query string that would be passed to the schema.
  # @raise [GraphqlTestHelpers::GraphqlException] when an error is present in the GraphQL response
  def query!(query, variables: {}, context: {}, schema: FriendfaceSchema)
    query(query, variables: variables, context: context, schema: schema)
    raise GraphqlTestHelpers::GraphqlException, gql_response if gql_response.errors?
  end

  # Execute a GraphQL query with the provided Schema
  # @param query required The query string that would be passed to the schema.
  def query(query, variables: {}, context: {}, schema: FriendfaceSchema)
    converted = variables.deep_transform_keys! { |key| key.to_s.camelize(:lower) } || {}

    res = schema.execute(query, variables: converted, context: context, operation_name: nil)
    @gql_response = GQLResponse.new(res.to_h)
  end

  alias_method :mutation, :query
end
