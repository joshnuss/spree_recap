require 'spec_helper'

describe SpreeRecap::Summary do
  let(:summary) { SpreeRecap::Summary.new(1.day.ago..Time.now) }

  context "registrations" do
    let!(:user1) { create(:user, created_at: 1.hour.ago) }
    let!(:user2) { create(:user, created_at: 2.hour.ago) }
    let!(:old_user) { create(:user, created_at: 2.days.ago) }

    specify { summary.registrations.should == [user1, user2] }
  end

  context "orders" do
    let!(:order1) { create(:order, completed_at: 1.hour.ago) }
    let!(:order2) { create(:order, completed_at: 2.hour.ago) }
    let!(:old_order) { create(:order, completed_at: 2.days.ago) }

    specify { summary.orders.should == [order1, order2] }
  end

  context "shipments" do
    let!(:shipment1) { create(:shipment, state: 'shipped', shipped_at: 1.hour.ago) }
    let!(:shipment2) { create(:shipment, state: 'shipped', shipped_at: 2.hour.ago) }
    let!(:old_shipment) { create(:shipment, state: 'shipped', shipped_at: 2.days.ago) }

    specify { summary.shipments.should == [shipment1, shipment2] }
  end
end
