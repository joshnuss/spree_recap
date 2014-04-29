module SpreeRecap
  class Summary
    include Spree

    def initialize(range)
      @range = range
    end

    def comments?
      defined? Comment
    end

    def registrations
      @registrations ||= User.where(created_at: @range)
    end

    def orders
      @orders ||= Order.complete
                       .order(completed_at: :desc)
                       .where(completed_at: @range)
    end

    def shipments
      @shipments ||= Shipment.shipped
                             .where(shipped_at: @range)
    end

    def state_changes
      @state_changes ||= StateChange.where(created_at: @range, user_id: admin_users.map(&:id))
    end

    def admin_users
      admin = Role.find_by(name: 'admin')
      admin.users
    end

    def comments
      @comments ||= comments? ? Comment.where(created_at: @range) : []
    end

    def collaborators
      if !@collaborators
        @collaborators = Hash[admin_users.map {|user| [user, []]}]

        comments.group_by(&:user).each do |user, comments|
          @collaborators[user] += comments
        end

        state_changes.group_by(&:user).each do |user, state_changes|
          @collaborators[user] += state_changes
        end

        @collaborators.delete_if {|user, records| records.empty? }

        @collaborators = Hash[@collaborators.sort {|k, v| v[1].created_at }]
      end

      @collaborators
    end
  end
end
