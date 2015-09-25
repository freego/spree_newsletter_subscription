begin
  require 'mailchimp'
rescue LoadError => e
  raise unless e.message =~ /mailchimp/
  friendly_ex = e.exception('please install the mailchimp-api gem first!')
  friendly_ex.set_backtrace(e.backtrace)
  raise friendly_ex
end

module SpreeNewsletterSubscription
  class MailchimpSubscriber < BaseSubscriber

    private

    def client
      Mailchimp::API.new(get_config(:api_key))
    end

    def subscribe_recipient!
      client.lists.subscribe(@list, { email: @email })
    end
  end
end
