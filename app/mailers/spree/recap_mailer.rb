module Spree
  class RecapMailer < Spree::BaseMailer
    def summary(range)
      @summary = SpreeRecap::Summary.new(range)
      to_address = @summary.admin_users.map(&:email)

      mail(from: from_address, to: to_address)
    end
  end
end
