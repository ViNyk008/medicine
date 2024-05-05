class Doctor < ApplicationRecord
    attribute :name, :string
    attribute :email, :string

    validates_presence_of :name, :email
end
