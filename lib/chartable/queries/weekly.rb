module Chartable
  module Queries
    class Weekly
      # It returns analytics data for the weekly period.
      # Example output: `{"01/28/18 - 02/03/18" => 1, "02/11/18 - 02/17/18" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:)
        scope.group("CONCAT(DATE_FORMAT(DATE(DATE_ADD(#{on}, INTERVAL(1-DAYOFWEEK(#{on})) DAY)), '%m/%d/%y'), ' - ', DATE_FORMAT(DATE(DATE_ADD(#{on}, INTERVAL(7-DAYOFWEEK(#{on})) DAY)),'%m/%d/%y'))").size
      end
    end
  end
end
