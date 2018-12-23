require 'active_support'
require 'active_record'

module Chartable
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    class_methods do
      # It returns analytics hash created from the given criteria
      #
      # @return [Hash]
      def analytics(period, from: nil, to: nil, on: 'created_at', order: 'asc')
        query_order = if order.to_s.downcase == 'desc'
          'desc'
        else
          'asc'
        end

        period_query = Chartable::PeriodQuery.build(period)
        scope = Chartable::RangeQuery.call(self, on: on, from: from, to: to)
        period_query.call(scope, on: on, order: query_order)
      end
    end
  end
end

ActiveRecord::Base.send(:include, Chartable::ActiveRecordExtension)
