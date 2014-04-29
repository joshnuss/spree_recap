require 'spec_helper'

describe SpreeRecap::Summary do
  let(:summary) { SpreeRecap::Summary.new(1.day.ago..Time.now) }

  context "registrations" do
    let!(:user1) { create(:user, created_at: 1.hour.ago) }
    let!(:user2) { create(:user, created_at: 2.hour.ago) }
    let!(:user3) { create(:user, created_at: 2.days.ago) }

    specify { summary.registrations.should == [user1, user2] }
  end
end
