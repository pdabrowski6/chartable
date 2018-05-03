require 'chronic'

module Chartable
  class RangeQuery
    # Returns scope filtered according to the given date criteria.
    # If dates are not given it returns original scope.
    # Given value is parsed by Chronic gem and transformed into the data format
    #
    # @return [Model::ActiveRecord_Relation]
    def self.call(scope, on:, from: nil, to: nil)
      from_date = Chronic.parse(from)
      to_date = Chronic.parse(to)

      return scope if from_date.nil? && to_date.nil?

      case
        when from_date.nil?
          scope.where("DATE(#{on}) <= ?", to_date.to_date)
        when to_date.nil?
          scope.where("DATE(#{on}) >= ?", from_date.to_date)
        else
          scope.where("DATE(#{on}) >= ? AND DATE(#{on}) <= ?", from_date.to_date, to_date.to_date)
      end
    end
  end
end
