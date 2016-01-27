Spree.user_class.class_eval do
  after_save :newsletter_subscription

  def subscribe_to_newsletter!
    update_attributes(subscribed_to_mailing_list: true)
  end

  private

  def newsletter_subscription
    if id_changed? || subscribed_to_mailing_list_changed?
      if subscribed_to_mailing_list
        Spree::NewsletterSubscription.new(newsletter_params).save!
      else
        # TODO unsubscribe?
      end
    end
  end

  # override to send more data to the provider
  def newsletter_params
    {
      email: email,
      terms: '1'
    }
  end
end
