module Api
  module V1
    class DevelopersController < Api::BaseController
      before_action :set_post, only: %i[show]

      def set_post
        @developer = Developer.find(params[:id])
      end

      def show
        if stale?(last_modified: @developer.updated_at.utc)
          cache_options = {compress: true, expires_in: 24.hours, race_condition_ttl: 10}
          Rails.cache.fetch("#{@developer.cache_key}/#{__method__}", cache_options) do
            render json: @developer, status: :ok
          end
        end
      end

      def index
       if stale?(last_modified: Developer.maximum(:updated_at))
          developers = Developer.all
          if programming_language = params[:prog_lang]
            developers = developers.where(programming_languages: programming_language)
          end
          render json: developers, each_serializer: DeveloperSerializer, status: :ok
       end
      end


    end
  end
end
