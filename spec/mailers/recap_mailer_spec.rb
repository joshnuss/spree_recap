require 'spec_helper'

describe Spree::RecapMailer do
  context "#summary" do
    let!(:admin_user1) { create(:admin_user, email: 'admin1@example.com') }
    let!(:admin_user2) { create(:admin_user, email: 'admin2@example.com') }

    context "single day" do
      subject { Spree::RecapMailer.summary(1.day.ago..Time.now) }

      its(:from) { should == ['spree@example.com'] }
      its(:bcc) { should == ['admin1@example.com', 'admin2@example.com'] }
      its(:subject) { should == "[Spree Demo Site] Recap for #{1.day.ago.to_date.to_s}"}
    end

    context "multiple days" do
      subject { Spree::RecapMailer.summary(3.days.ago..Time.now) }

      its(:from) { should == ['spree@example.com'] }
      its(:bcc) { should == ['admin1@example.com', 'admin2@example.com'] }
      its(:subject) { should == "[Spree Demo Site] Recap for #{3.days.ago.to_date.to_s} to #{Date.today.to_s}"}
    end
  end
end
