class Patient < ApplicationRecord
    attribute :name, :string
    attribute :email, :string
    attribute :timezone, :string

    has_many :patient_medications
    has_many :medications, through: :patient_medication_mapping
    validates_presence_of :name, :email, :timezone
end
