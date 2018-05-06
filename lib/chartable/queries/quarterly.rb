module Chartable
  module Queries
    class Quarterly
      # It returns analytics data for the quarterly period.
      # Example output: `{"Q1 2018" => 1, "Q2 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:)
        if ActiveRecord::Base.connection.class.to_s.match(/sqlite/i)
          scope.group("strftime('%m %Y', #{on})").size.transform_keys do |key|
            month_number = key.match(/^[0-9]{2}(?= )/).to_s
            quarter = case month_number.to_i
              when 1..3 then 1
              when 4..6 then 2
              when 7..9 then 3
              else
                4
              end

            key.gsub(month_number, "Q#{quarter}")
          end
        else
          scope.group("CONCAT('Q', QUARTER(#{on}), DATE_FORMAT(#{on},' %Y'))").size
        end
      end
    end
  end
end
