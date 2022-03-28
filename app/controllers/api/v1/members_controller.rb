module Api
  module V1
  
    class MembersController < ApplicationController
      before_action :authenticate_user!
    
      def index
        user = current_user
    
        render json: serialize_user(user), status: :ok
      end
    
    
      def show
        user = User.find(params[:id])
    
        render json: serialize_user(user), status: :ok
      end
    
      
      private
      def serialize_user(user)
        {
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          fullname: "#{user.first_name} #{user.last_name}",
          profile_pic: url_for(user.profile_pic)
        }
      end
    end
  end
end
