Spree.user_class.class_eval do

  # example method
  def subscribe_to_newsletter!
    if id_changed? || subscribed_to_mailing_list_changed?
      if subscribed_to_mailing_list
        Spree::NewsletterSubscription.new(newsletter_params).save!
      else
        # TODO unsubscribe?
      end
    end
  end

  private

  def newsletter_params
    {
      email: email,
      terms: '1'
    }
  end
end
