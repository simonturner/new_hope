require 'spec_helper'

require_relative File.expand_path('../../../../app/models/event.rb', __FILE__)

describe 'Event' do

  before do
    @event = FactoryGirl.create(:event)
  end

  it "has a valid factory" do
    @event.should be_valid
  end

  it 'is not valid without a name' do
     @event.name = nil
     @event.should_not be_valid
  end

  it 'is not valid without a organisation' do
     @event.organisation = nil
     @event.should_not be_valid
  end

  it 'is not valid without a cost' do
     @event.cost = nil
     @event.should_not be_valid
  end

  it 'is not valid without a access' do
     @event.access = nil
     @event.should_not be_valid
  end

  it 'is not valid without a referral' do
     @event.referral_id = nil
     @event.should_not be_valid
  end

  describe 'date' do

    before do
    @event = FactoryGirl.create(:date_today)
  end

    it 'knows whether the event is today' do
      @event.today?.should be true
    end

    it 'knows whether the event is this week' do
      @event.this_week?.should be true
    end

    it 'knows whether the event is this month' do
      @event.this_month?.should be true
    end

  end


end



describe 'Events' do

  before do
    @params = {}
    @events = Array.new
    2.times do

    @events << FactoryGirl.create(:populated_event)
    end

  end

  it 'returns a list of events' do
    result = Event.get_events(@params)
    result.length.should eq(2)
  end

  it 'filters list on Referral Type' do

    @events << FactoryGirl.create(:self_event)

    result = Event.get_events({:referral => '1'})

    result.length.should eq(2)
  end

  it 'filters list on tag' do
    @events << FactoryGirl.create(:no_sports_tags)

    result = Event.get_events({:tag => 'sports'})

    result.length.should eq(2)
  end

  it 'filters list on target' do
    @events << FactoryGirl.create(:no_women_targets)

    result = Event.get_events({:target => 'women'})

    result.length.should eq(2)
  end

  it 'filters list on events that occur today' do
    @events << FactoryGirl.create(:today)

    result = Event.get_events({ :quick_date => 'day' })

    result.length.should eq(1)
  end

  it 'filters list on events that occur this week' do
    @events << FactoryGirl.create(:today)

    result = Event.get_events({ :quick_date => 'week' })

    result.length.should eq(1)
  end

  it 'filters list on events that occur this month' do
    @events << FactoryGirl.create(:today)

    result = Event.get_events({ :quick_date => 'month' })

    result.length.should eq(1)
  end

  it 'filters list on events that occur on a given day' do
    dated_event = FactoryGirl.build(:today)
    selected_date = Date.new(2013, 02, 15)
    dated_event.complex_date.fixed_date = selected_date
    dated_event.save

    @events <<  dated_event

    result = Event.get_events({ :date => "02/15/2013" })

    result.length.should eq(1)
  end




end
