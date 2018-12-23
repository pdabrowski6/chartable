module Chartable
  module Queries
    class Daily
      # It returns analytics data for the daily period.
      # Example output: `{"October 09, 2018" => 1, "October 10, 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:, order:)
        if ActiveRecord::Base.connection.class.to_s.match(/postgresql/i)
          scope.group(Arel.sql("to_char(#{on},'FMMonth DD, YYYY')")).order(Arel.sql("to_char(#{on},'FMMonth DD, YYYY') #{order}")).size
        else
          scope.group(Arel.sql("DATE_FORMAT(#{on}, '%M %d, %Y')")).order(Arel.sql("DATE_FORMAT(#{on}, '%M %d, %Y') #{order}")).size
        end
      end
    end
  end
end
