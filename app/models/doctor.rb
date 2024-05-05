class Doctor < ApplicationRecord
    attribute :name, :string
    attribute :email, :string

    validates_presence_of :name, :email

    private

    def set_id
        self.id = SecureRandom.hex(16)
    end
end
