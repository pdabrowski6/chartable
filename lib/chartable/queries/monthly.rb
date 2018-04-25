module Chartable
  module Queries
    class Monthly
      # It returns analytics data for the monthly period.
      # Example output: `{"November 2018" => 1, "October 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:)
        scope.group("DATE_FORMAT(#{on},'%M %Y')").size
      end
    end
  end
end
