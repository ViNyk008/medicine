class Medication < ApplicationRecord
    attribute :name, :string

    has_many :patient_medications
    has_many :patients, through: :patient_medication_mapping

    validates_presence_of :name

    private

    def set_id
        self.id = SecureRandom.hex(16)
    end
end
