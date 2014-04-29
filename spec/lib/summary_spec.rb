require 'spec_helper'

describe SpreeRecap::Summary do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user, created_at: 2.days.ago) }

  let(:summary) { SpreeRecap::Summary.new(1.day.ago..Time.now) }

  specify { summary.registrations.should == [user1, user2] }
end
