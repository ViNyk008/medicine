class Medication < ApplicationRecord
    attribute :name, :string
    attribute :status, :string
    attribute :serial_id, :integer
    attribute :description, :string

    has_many :prescriptions
    has_many :patients, through: :prescriptions

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    before_validation :normalize_name
    before_create :set_id

    private
    def set_id
        self.id = SecureRandom.hex(16)
    end

    def normalize_name
        self.name = name.downcase if name.present?
    end
end
