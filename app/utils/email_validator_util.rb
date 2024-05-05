require 'mail'
class EmailValidatorUtil
    def self.valid_email?(email)
        begin
            parsed_email = Mail::Address.new(email)
            return parsed_email.domain && parsed_email.address == email
        rescue Mail::Field::ParseError
            return false
        end
    end
end

