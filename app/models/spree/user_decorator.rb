Spree.user_class.class_eval do
  # example method
  def subscribe_to_newsletter!
    if subscribed_to_mailing_list
      NewsletterSubscriptionJob.perform_later(newsletter_params)
    else
      # TODO unsubscribe?
    end
  end

  private

  # override to send more data to the provider
  def newsletter_params
    {
      email: email,
      terms: '1'
    }
  end
end
