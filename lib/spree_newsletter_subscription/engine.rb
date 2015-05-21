module SpreeNewsletterSubscription
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_newsletter_subscription'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_newsletter_subscription.environment', before: :load_config_initializers do |app|
      SpreeNewsletterSubscription::Config = SpreeNewsletterSubscription::Configuration.new
      Spree::PermittedAttributes.user_attributes.push :subscribed_to_mailing_list
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
