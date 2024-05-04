class Doctor < ApplicationRecord
    attribute :name, :string
    # attribute :doctor_id, :string
    validates_presence_of :name
end
