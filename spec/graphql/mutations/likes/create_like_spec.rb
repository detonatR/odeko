# frozen_string_literal: true

require "rails_helper"
require "support/graphql_test_helpers"

RSpec.describe Mutations::Likes::CreateLike, type: :mutation do
  include GraphqlTestHelpers

  subject { described_class }

  it { is_expected.to accept_argument(:post_id).of_type("ID!") }

  describe "mutation" do
    subject(:response) { gql_response.data["createLike"].deep_symbolize_keys }

    let(:context) { { current_user: "example" } } # header testing left up to imaginary auth

    let(:variables) do
      {
        post_id: 1
      }
    end

    let(:execute_query) do
      query(mutation_string, variables: variables, context: context)
    end

    let(:mutation_string) do
      <<-GRAPHQL
        mutation createLike($postId: ID!) {
          createLike(input: {
            postId: $postId,
          }) {
            postId
            user
          }
        }
      GRAPHQL
    end

    context "with valid params" do
      let(:expected_result) do
        {
          postId: "1",
          user: "example"
        }
      end

      it "returns success" do
        execute_query
        expect(response).to eq(expected_result)
      end

      it "creates record" do
        expect { execute_query }.to change(Like, :count).by(1)
      end
    end

    context "with invalid params" do
      let!(:like) { create(:like, user: "example", post_id: 1) }

      it "returns errors" do
        execute_query
        expect(gql_response.errors.first["message"]).to eq "User has already been taken"
      end
    end
  end
end
