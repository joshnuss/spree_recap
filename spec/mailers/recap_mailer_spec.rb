require 'spec_helper'

describe Spree::RecapMailer do
  context "#summary" do
    let!(:admin_user1) { create(:admin_user, email: 'admin1@example.com') }
    let!(:admin_user2) { create(:admin_user, email: 'admin2@example.com') }

    subject { Spree::RecapMailer.summary(1.day.ago..Time.now) }

    its(:from) { should == ['spree@example.com'] }
    its(:bcc) { should == ['admin1@example.com', 'admin2@example.com'] }
  end
end
