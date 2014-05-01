module Spree
  class RecapMailer < Spree::BaseMailer
    def summary(range)
      @summary = SpreeRecap::Summary.new(range)
      to_address = @summary.admin_users.map(&:email)
      subject = "[#{Spree::Config.site_name}] "

      if single_day?(range)
        subject += t(:recap_single_day, date: range.begin.to_date)
      else
        subject += t(:recap_multiple_days, from: range.begin.to_date, to: range.end.to_date)
      end

      mail(from: from_address, bcc: to_address, subject: subject)
    end

  private

    def single_day?(range)
      (range.end.to_date - range.begin.to_date) <= 1
    end
  end
end
