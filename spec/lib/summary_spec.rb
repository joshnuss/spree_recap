require 'spec_helper'

describe SpreeRecap::Summary do
  let(:admin_user) { create(:admin_user) }
  let(:non_admin_user) { create(:user) }
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

  context "state_changes" do
    let!(:state_change1) { create(:state_change, user: admin_user, created_at: 1.hour.ago) }
    let!(:state_change2) { create(:state_change, user: admin_user, created_at: 2.hour.ago) }
    let!(:state_change_non_admin) { create(:state_change, user: non_admin_user, created_at: 2.hour.ago) }
    let!(:old_state_change) { create(:state_change, user: admin_user, created_at: 2.days.ago) }

    specify { summary.state_changes.should == [state_change1, state_change2] }
    specify { summary.collaborators.should == {admin_user => [state_change1, state_change2]}}
  end

  context "comments" do
    let!(:comment1)    { create(:comment, user: admin_user, created_at: 1.hour.ago) }
    let!(:comment2)    { create(:comment, user: admin_user, created_at: 2.hour.ago) }
    let!(:old_comment) { create(:comment, user: admin_user, created_at: 2.days.ago) }

    context "defined" do
      specify { summary.comments.should == [comment2, comment1]}
      specify { summary.collaborators.should == {admin_user => [comment2, comment1]}}
    end

    context "undefined" do
      before { summary.stub(comments?: false) }

      specify { summary.comments.should == []}
      specify { summary.collaborators.should == {}}
    end
  end
end
