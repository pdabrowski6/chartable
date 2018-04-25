require 'spec_helper'

describe Chartable::ActiveRecordExtension do
  describe '#analytics' do
    it 'returns analytics for given period and column' do
      period = :yearly
      on = 'created_at'
      from = Date.today
      to = Date.today
      allow(Chartable::PeriodQuery).to receive(:build).with(period).and_return(Chartable::Queries::Yearly)
      scope = double('scope')
      allow(Chartable::RangeQuery).to receive(:call).with(
        User, on: on, from: from, to: to
      ).and_return(scope)
      analytics = double('analytics')
      allow(Chartable::Queries::Yearly).to receive(:call).with(
        scope, on: on
      ).and_return(analytics)

      expect(User.analytics(:yearly, from: from, to: to, on: on)).to eq(analytics)
    end
  end
end
