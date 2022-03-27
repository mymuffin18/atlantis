module Api
  module V1
    class AdminSessionsController < Devise::SessionsController
      respond_to :json

      private

      def respond_with(_resource, _opts = {})
        if current_admin
          render json: {
            status: { code: 200, message: 'Logged in successfully.' },
            data: current_admin
          }, status: :ok
        else
          render json: {
            message: 'Please sign in your account.'
          }, status: :unauthorized
        end
      end

      def respond_to_on_destroy
        if current_admin
          render json: {
            status: 200,
              message: 'logged out successfully'
          }, status: :ok
        else
          render json: {
            status: 401,
              message: "Couldn't find an active session."
          }, status: :unauthorized
        end
      end
    end
  end
end
