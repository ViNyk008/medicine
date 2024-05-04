class Patient < ApplicationRecord
    attribute :name, :string
    attribute :email, :string
    attribute :country_name, :string
    validates_presence_of :name, :email, :country_name
end
