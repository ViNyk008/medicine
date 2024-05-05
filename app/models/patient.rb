class Patient < ApplicationRecord
    attribute :name, :string
    attribute :email, :string
    attribute :country_code, :string

    has_many :patient_medication_mappings
    has_many :medications, through: :patient_medication_mappings
    validates_presence_of :name, :email, :country_code
    validate :validate_email

    before_create :set_id

    private
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

    def get_time_zone_from_country_code
        GetTimeZoneFromCountryCodeUtil.get_time_zone_from_country_code(self.country_code)
    end
end

