module SpreeNewsletterSubscription
  class BaseSubscriber
    def initialize(email, locale = nil)
      @email = email
      @locale = locale
    end

    def subscribe!
      logger.debug("#subscribe!(#{@email})")
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
      conf = if @locale && config[@locale.to_sym]
        config[@locale.to_sym][key]
      end

      conf ||= config[key]
    end

    def logger
      @logger ||= Logger.new(Rails.root.join('log/newsletter_subscription.log'))
    end
  end
end
