require 'spec_helper'

describe Chartable::PeriodQuery do
  describe '.build' do
    it 'raises Chartable::Errors::InvalidPeriodError error if given period is invalid' do
      expect {
        described_class.build(:hourly)
      }.to raise_error(Chartable::Errors::InvalidPeriodError, "hourly is not valid, valid one are: daily, weekly, quarterly, yearly, monthly")
    end

    it 'returns Chartable::Queries::Daily class if period is :daily' do
      expect(described_class.build(:daily)).to eq(Chartable::Queries::Daily)
    end

    it 'returns Chartable::Queries::Weekly class if period is :weekly' do
      expect(described_class.build(:weekly)).to eq(Chartable::Queries::Weekly)
    end

    it 'returns Chartable::Queries::Monthly class if period is :monthly' do
      expect(described_class.build(:monthly)).to eq(Chartable::Queries::Monthly)
    end

    it 'returns Chartable::Queries::Quarterly class if period is :quarterly' do
      expect(described_class.build(:quarterly)).to eq(Chartable::Queries::Quarterly)
    end

    it 'returns Chartable::Queries::Yearly class if period is :yearly' do
      expect(described_class.build(:yearly)).to eq(Chartable::Queries::Yearly)
    end
  end
end
