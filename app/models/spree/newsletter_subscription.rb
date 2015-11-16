module Spree
  class NewsletterSubscription
    extend ActiveModel::Naming
    extend ActiveModel::Translation

    attr_reader :errors

    def initialize(attributes = {})
      @attributes = attributes
      @errors = ActiveModel::Errors.new(self)
    end

    def save!
      return false unless validate!

      result = provider.new(@attributes).subscribe!
      errors.add(:base, result[:error]) unless result[:success]
      result[:success]
    end

    def read_attribute_for_validation(attr)
      send(attr)
    end

    def validate!
      if @attributes[:email].blank?
        errors.add(:email, I18n.t("spree.newsletter_subscription.validations.missing"))
      end
      if @attributes[:terms] != '1'
        errors.add(:terms, I18n.t("spree.newsletter_subscription.validations.must_accept"))
      end
      errors.none?
    end

    private

    def provider
      class_name = SpreeNewsletterSubscription::Config[:provider].classify
      "SpreeNewsletterSubscription::#{class_name}Subscriber".constantize
    end
  end
end
