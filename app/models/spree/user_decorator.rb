Spree.user_class.class_eval do
  after_save :newsletter_subscription

  private

  def newsletter_subscription
    if id_changed? || subscribed_to_mailing_list_changed?
      if subscribed_to_mailing_list
        params = { email: email,
                   terms: '1' }
        Spree::NewsletterSubscription.new(params).save!
      else
        # TODO unsubscribe?
      end
    end
  end
end