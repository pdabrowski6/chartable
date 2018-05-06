module Chartable
  module Queries
    class Monthly
      # It returns analytics data for the monthly period.
      # Example output: `{"November 2018" => 1, "October 2018" => 1}`
      # SQLite does not support DATE_FORMAT function so a little hack is needed
      #
      # @return [Hash]
      def self.call(scope, on:)
        if ActiveRecord::Base.connection.class.to_s.match(/sqlite/i)
          scope.group("strftime('%m %Y', #{on})").size.transform_keys do |key|
            month_number = key.match(/^[0-9]{2}(?= )/).to_s
            key.gsub(month_number, Date::MONTHNAMES[month_number.to_i])
          end
        else
          scope.group("DATE_FORMAT(#{on},'%M %Y')").size
        end
      end
    end
  end
end
