module SpreeNewsletterSubscription
  class BaseSubscriber
    def initialize(attributes, locale = nil)
      @attributes = attributes
    end

    def subscribe!
      logger.debug("#subscribe!(#{@attributes[:email]})")
      begin
        subscribe_recipient!
        { success: true }
      rescue Exception => e
        logger.debug(e.message)
        { success: false, error: e.message }
      end
    end

    private

    def config
      @config ||= SpreeNewsletterSubscription::Config[:provider_config]
    end

    def get_config(key)
      locale = @attributes[:locale]
      conf = if locale.present? && config[locale.to_sym]
        config[locale.to_sym][key]
      end

      conf ||= config[key]
    end

    def logger
      @logger ||= Logger.new(Rails.root.join('log/newsletter_subscription.log'))
    end
  end
end
