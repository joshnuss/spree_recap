module SpreeRecap
  class Summary
    include Spree

    def initialize(range)
      @range = range
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

    def comments
      @comments ||= comments? ? Comment.where(created_at: @range) : []
    end

    def comments?
      defined? Spree::Comment
    end

  end
end
