class Doctor < ApplicationRecord
    attribute :name, :string
    attribute :email, :string
    attribute :status, :string, default: "active"
    attribute :specialization, :string, default: nil
    attribute :phone_number, :string

    validates_presence_of :name, :email
    validates_uniqueness_of :email
    validate :validate_email
    
    has_many :prescriptions
    has_many :patients, through: :prescriptions

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
