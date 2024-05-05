class Doctor < ApplicationRecord
    attribute :name, :string
    attribute :email, :string

    validates_presence_of :name, :email
    validate :validate_email
   
    before_create :set_id

    private
    def set_id
        self.id = SecureRandom.hex(16)
    end

    def validate_email
        is_valid = EmailValidatorUtil.valid_email?(self.email)
        if is_valid.nil?
            self.errors.add(:not_valid, "mail")
            return
        end
    end
end
