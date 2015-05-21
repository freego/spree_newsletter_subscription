module SpreeNewsletterSubscription
  class Configuration < Spree::Preferences::Configuration
    preference :api_key, :hash
    preference :list_id, :hash
    # preference :double_opt_in, :boolean, default: true
    # preference :send_welcome,  :boolean, default: true
    # preference :send_notify,   :boolean, default: true
    # preference :merge_vars,    :string, default: ''
  end
end