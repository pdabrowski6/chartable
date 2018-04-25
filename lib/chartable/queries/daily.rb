module Chartable
  module Queries
    class Daily
      # It returns analytics data for the daily period.
      # Example output: `{"October 09, 2018" => 1, "October 10, 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:)
        scope.group("DATE_FORMAT(#{on}, '%M %d, %Y')").size
      end
    end
  end
end
