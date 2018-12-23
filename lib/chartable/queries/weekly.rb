module Chartable
  module Queries
    class Weekly
      # It returns analytics data for the weekly period.
      # Example output: `{"01/28/2018 - 02/03/2018" => 1, "02/11/2018 - 02/17/2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:, order:)
        if ActiveRecord::Base.connection.class.to_s.match(/sqlite/i)
          scope.group("strftime('%m/%d/%Y', date(#{on}, 'weekday 0', '-7 days')) || ' - ' || strftime('%m/%d/%Y', date(#{on}, 'weekday 0', '-1 days'))").size
        elsif ActiveRecord::Base.connection.class.to_s.match(/postgresql/i)
          scope
            .group("concat(to_char(date_trunc('week', #{on}) + '-1 day', 'MM/DD/YYYY'), ' - ', to_char(date_trunc('week', #{on}) + '5 days', 'MM/DD/YYYY'))")
            .order("concat(to_char(date_trunc('week', #{on}) + '-1 day', 'MM/DD/YYYY'), ' - ', to_char(date_trunc('week', #{on}) + '5 days', 'MM/DD/YYYY')) #{order}").size
        else
          scope
            .group(Arel.sql("CONCAT(DATE_FORMAT(DATE(DATE_ADD(#{on}, INTERVAL(1-DAYOFWEEK(#{on})) DAY)), '%m/%d/%Y'), ' - ', DATE_FORMAT(DATE(DATE_ADD(#{on}, INTERVAL(7-DAYOFWEEK(#{on})) DAY)),'%m/%d/%Y'))"))
            .order(Arel.sql("CONCAT(DATE_FORMAT(DATE(DATE_ADD(#{on}, INTERVAL(1-DAYOFWEEK(#{on})) DAY)), '%m/%d/%Y'), ' - ', DATE_FORMAT(DATE(DATE_ADD(#{on}, INTERVAL(7-DAYOFWEEK(#{on})) DAY)),'%m/%d/%Y')) #{order}")).size
        end
      end
    end
  end
end
