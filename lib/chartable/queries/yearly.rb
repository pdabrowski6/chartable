module Chartable
  module Queries
    class Yearly
      # It returns analytics data for the yearly period.
      # Example output: `{ 2017 => 1, 2018 => 1 }`
      #
      # @return [Hash]
      def self.call(scope, on:, order:)
        if ActiveRecord::Base.connection.class.to_s.match(/sqlite/i)
          scope.group("cast(strftime('%Y', #{on}) as decimal)").size
        elsif ActiveRecord::Base.connection.class.to_s.match(/postgresql/i)
          scope.group("cast(to_char(#{on},'YYYY') as integer)").order("cast(to_char(#{on},'YYYY') as integer) #{order}").size
        else
          scope.group(Arel.sql("YEAR(#{on})")).order(Arel.sql("YEAR(#{on}) #{order}")).size
        end
      end
    end
  end
end
