module Api
  module V1
    class DevelopersController < Api::BaseController
      before_action :set_developer, only: %i[show]

      def show
        return unless stale?(last_modified: @developer.updated_at.utc)
        cache_options = { compress: true, expires_in: 24.hours, race_condition_ttl: 10 }
        Rails.cache.fetch("#{@developer.cache_key}/#{__method__}", cache_options) do
          render json: @developer, status: :ok
        end
      end

      def index
        return unless stale?(last_modified: Developer.maximum(:updated_at))
        developers = Developer.all
        render json: developers, status: :ok
      end

      private

      def set_developer
        @developer = Developer.find(params[:id])
      end
    end
  end
end
