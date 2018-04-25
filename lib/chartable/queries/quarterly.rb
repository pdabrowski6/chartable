module Chartable
  module Queries
    class Quarterly
      # It returns analytics data for the quarterly period.
      # Example output: `{"Q1 2018" => 1, "Q2 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:)
        scope.group("CONCAT('Q', QUARTER(#{on}), DATE_FORMAT(#{on},' %Y'))").size
      end
    end
  end
end
