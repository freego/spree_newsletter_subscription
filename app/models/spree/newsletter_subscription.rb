module Spree
  class NewsletterSubscription
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_accessor :email, :terms, :locale

    validates :email, presence: true
    validates :terms, acceptance: true

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def save!
      return unless valid?

      result = SpreeNewsletterSubscription::MailchimpSubscriber.new(email, locale).subscribe!
      if !result[:success] && result[:error].present?
        errors.add(:base, result[:error])
      end

      result[:success]
    end

    def persisted?
      false
    end
  end
end
