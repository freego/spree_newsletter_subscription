module SpreeNewsletterSubscription
  class Configuration < Spree::Preferences::Configuration
    preference :provider, :string, default: 'mailchimp'
    preference :provider_config, :hash
  end
end
