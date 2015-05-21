module Spree
  class NewsletterSubscriptionsController < StoreController
    def create
      @subscription = Spree::NewsletterSubscription.new(params[:newsletter_subscription])
      @success = @subscription.save!
    end
  end
end
