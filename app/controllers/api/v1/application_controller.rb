module Api
  module V1
    class ApplicationController < ::ApplicationController
      before_action :force_json_format

      private

      def force_json_format
        request.format = :json
      end
    end
  end
end
