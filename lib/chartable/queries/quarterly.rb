module Chartable
  module Queries
    class Quarterly
      # It returns analytics data for the quarterly period.
      # Example output: `{"Q1 2018" => 1, "Q2 2018" => 1}`
      #
      # @return [Hash]
      def self.call(scope, on:, order:)
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
        elsif ActiveRecord::Base.connection.class.to_s.match(/postgresql/i)
          scope.group("concat('Q', to_char(#{on},'Q YYYY'))").order("concat('Q', to_char(#{on},'Q YYYY')) #{order}").size
        else
          scope.group("CONCAT('Q', QUARTER(#{on}), DATE_FORMAT(#{on},' %Y'))").order("CONCAT('Q', QUARTER(#{on}), DATE_FORMAT(#{on},' %Y')) #{order}").size
        end
      end
    end
  end
end
