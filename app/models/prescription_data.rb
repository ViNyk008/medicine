class PrescriptionData
    include StoreModel::Model
    
    attribute :time, DateTime.to_array_type, default: nil
    attribute :day, :string, default: nil
    attribute :date, :Int, default: nil
end