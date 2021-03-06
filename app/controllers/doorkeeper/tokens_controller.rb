class Doorkeeper::TokensController < Doorkeeper::ApplicationController
  def create
    if token.authorize
      render :json => token.authorization
    else
      render :json => token.error_response
    end
  end

  private

  def token
    @token ||= Doorkeeper::OAuth::AccessTokenRequest.new(params)
  end
end
