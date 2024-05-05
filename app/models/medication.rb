class Medication < ApplicationRecord
    attribute :name, :string

    has_many :patient_medications
    has_many :patients, through: :patient_medication_mappings

    validates_presence_of :name
    before_create :set_id

    private

    def set_id
        self.id = SecureRandom.hex(16)
    end
end
