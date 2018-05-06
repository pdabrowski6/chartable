module Chartable
  module Queries
    class Daily
      # It returns analytics data for the daily period.
      # Example output: `{"October 09, 2018" => 1, "October 10, 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:)
        if ActiveRecord::Base.connection.class.to_s.match(/sqlite/i)
          scope.group("strftime('%m %d, %Y', #{on})").size.transform_keys do |key|
            data = key.split(" ")
            month_number = data.shift
            month_name = Date::MONTHNAMES[month_number.to_i]
            data.unshift(month_name)
            data.join(" ")
          end
        elsif ActiveRecord::Base.connection.class.to_s.match(/postgresql/i)
          scope.group("to_char(#{on},'FMMonth DD, YYYY')").size
        else
          scope.group("DATE_FORMAT(#{on}, '%M %d, %Y')").size
        end
      end
    end
  end
end
