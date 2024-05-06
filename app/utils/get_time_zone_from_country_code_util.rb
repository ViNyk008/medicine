class GetTimeZoneFromCountryCodeUtil
    require 'tzinfo'
    def self.get_offset_from_country_code(country_code)
        country_zones = TZInfo::Country.get(country_code).zones.first
        current_offset = TZInfo::Timezone.get(country_zones.as_json["identifier"]).current_period.utc_offset
        offset_hours = current_offset / 3600
        offset_minutes = (current_offset % 3600) / 60
        offset_string = "%+03d:%02d" % [offset_hours, offset_minutes]
    end

    def self.get_time_zone(country_code)
        country_zones = TZInfo::Country.get(country_code).zones.as_json.first["identifier"]
    end
end