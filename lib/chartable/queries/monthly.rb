module Chartable
  module Queries
    class Monthly
      # It returns analytics data for the monthly period.
      # Example output: `{"November 2018" => 1, "October 2018" => 1}`
      # SQLite does not support DATE_FORMAT function so a little hack is needed
      #
      # @return [Hash]
      def self.call(scope, on:, order:)
        if ActiveRecord::Base.connection.class.to_s.match(/postgresql/i)
          scope.group(Arel.sql("#{on}, to_char(#{on},'FMMonth YYYY')")).order(Arel.sql("#{on} #{order}")).size
        else
          scope.group(Arel.sql("#{on}, DATE_FORMAT(#{on},'%M %Y')")).order(Arel.sql("#{on} #{order}")).size
        end
      end
    end
  end
end
