class NewsletterSubscriptionJob < ActiveJob::Base
  def perform(params)
    Spree::NewsletterSubscription.new(params).save!
  end
end
