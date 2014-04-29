module SpreeRecap
  class Summary
    include Spree

    def initialize(range)
      @range = range
    end

    def registrations
      @registrations ||= User.where(created_at: @range)
    end
  end
end
