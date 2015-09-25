begin
  require 'mailup'
rescue LoadError => e
  raise unless e.message =~ /mailup/
  friendly_ex = e.exception('please install the mailup gem first!')
  friendly_ex.set_backtrace(e.backtrace)
  raise friendly_ex
end

module SpreeNewsletterSubscription
  class MailupSubscriber < BaseSubscriber

    private

    def client
      @client ||= MailUp::API.new({ client_id: get_config(:client_id),
                                    client_secret: get_config(:client_secret),
                                    oauth: oauth_token })
    end

    def oauth_client
      @oauth_client ||= OAuth2::Client.new(get_config(:client_id),
                                           get_config(:client_secret),
                                           site: 'https://services.mailup.com',
                                           authorize_url: '/Authorization/OAuth/Authorization',
                                           token_url: '/Authorization/OAuth/Token')
    end

    # TODO: can be cached for some time
    def oauth_token
      result = oauth_client.password.
                            get_token(get_config(:username), get_config(:password)).
                            to_hash
      result[:token] = result.delete(:access_token)
      result
    end

    def recipient
      {
        Email: @email,
        Name: @email
      }
    end

    def subscribe_recipient!
      recipient_id = client.console.list(get_config(:list_id)).import_recipient(recipient)
      client.console.list(get_config(:list_id)).subscribe(recipient_id)
    end

  end
end
