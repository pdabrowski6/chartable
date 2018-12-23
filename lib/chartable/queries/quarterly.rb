module Chartable
  module Queries
    class Quarterly
      # It returns analytics data for the quarterly period.
      # Example output: `{"Q1 2018" => 1, "Q2 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:, order:)
        if ActiveRecord::Base.connection.class.to_s.match(/postgresql/i)
          scope.group(Arel.sql("concat('Q', to_char(#{on},'Q YYYY'))")).order(Arel.sql("concat('Q', to_char(#{on},'Q YYYY')) #{order}")).size
        else
          scope.group(Arel.sql("CONCAT('Q', QUARTER(#{on}), DATE_FORMAT(#{on},' %Y'))")).order(Arel.sql("CONCAT('Q', QUARTER(#{on}), DATE_FORMAT(#{on},' %Y')) #{order}")).size
        end
      end
    end
  end
end
