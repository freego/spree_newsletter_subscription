require 'mailchimp'

module SpreeNewsletterSubscription
  class MailchimpSubscriber
    def initialize(email, locale = nil)
      @email = email
      @locale = locale
      @list = get_config(:list_id)
      @mailchimp = Mailchimp::API.new(get_config(:api_key))
      @logger = Logger.new(Rails.root.join('log/newsletter_subscription.log'))
    end

    def subscribe!
      @logger.debug("#subscribe!(#{@email})")
      begin
        result = @mailchimp.lists.subscribe(@list, { email: @email })
        { success: true }
      rescue Exception => e
        @logger.debug(e.message)
        { success: false, error: e.message }
      end
    end

    private

    def config
      @config ||= SpreeNewsletterSubscription::Config
    end

    def get_config(key)
      conf = config[key][@locale.to_sym] if @locale
      conf ||= config[key][:default]
    end
  end
end
