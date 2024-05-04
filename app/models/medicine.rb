class Medicine < ApplicationRecord
    attribute :name, :string

    validates_presence_of :name
end
