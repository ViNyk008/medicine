class Patient < ApplicationRecord
    attribute :name, :string
    attribute :email, :string
    attribute :country_code, :string

    has_many :patient_medication_mapping
    has_many :medications, through: :patient_medication_mapping
    validates_presence_of :name, :email, :country_code
end

def timezone_from_country_code(country_code)
    require 'tzinfo'
    country_zones = TZInfo::Country.get(country_code).zones
    country_zones.first
end
