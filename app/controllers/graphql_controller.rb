require 'rack/contrib'

require 'application_controller'
require 'graphql_endpoint/schema'

class GraphQLController < ApplicationController
  use Rack::PostBodyContentTypeParser

  get('/') { erb :graphiql }

  post '/' do
    result = Books::GraphQLEndpoint::BooksAppSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    json result
  end
end
