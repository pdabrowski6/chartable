module Chartable
  class PeriodQuery
    PERIODS = {
      daily: Chartable::Queries::Daily,
      weekly: Chartable::Queries::Weekly,
      quarterly: Chartable::Queries::Quarterly,
      yearly: Chartable::Queries::Yearly,
      monthly: Chartable::Queries::Monthly
    }

    # It returns the proper query object for selected period.
    # If given period is not supported it raises `Chartable::Errors::InvalidPeriodError` error
    #
    # @return [Class]
    def self.build(period)
      period_class = PERIODS[period]

      raise(Chartable::Errors::InvalidPeriodError, "#{period} is not valid, valid one are: #{PERIODS.keys.join(', ')}") if period_class.nil?

      period_class
    end
  end
end
