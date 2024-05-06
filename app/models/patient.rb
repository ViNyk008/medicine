class Patient < ApplicationRecord
    attribute :name, :string
    attribute :email, :string
    attribute :country_code, :string
    attribute :age, :string
    attribute :status, :string
    attribute :phone_number

    has_many :prescriptions
    has_many :medications, through: :prescriptions

    validates_presence_of :name, :email, :country_code
    validate :validate_email
    validates_uniqueness_of :email

    before_create :set_id

    def set_id
        self.id = SecureRandom.hex(16)
    end

    def validate_email
        is_valid = EmailValidatorUtil.valid_email?(self.email)
        if is_valid.nil?
            self.errors.add(:not_valid, " email")
            return
        end
    end

    def get_offset_from_country_code
        GetTimeZoneFromCountryCodeUtil.get_offset_from_country_code(self.country_code)
    end

    def get_time_zone
        GetTimeZoneFromCountryCodeUtil.get_time_zone(self.country_code)
    end
end

