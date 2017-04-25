module OpenWeather
  class History < Base
    def initialize options = {}
      super('http://history.openweathermap.org/data/2.5/history/city', options)
    end

    def extract_options!(options)
      valid_options = [ :id, :lat, :lon, :cnt, :city, :lang, :units, :APPID,
        :country, :bbox, :q, :type, :start]

      options.keys.each { |k| options.delete(k) unless valid_options.include?(k) }

      if options[:start]
        options[:start] = options[:start].to_time.to_i
        options[:cnt] ||= 1
      end

      options[:type] ||= 'hour'

      if options[:country]
        options[:q] = "#{options[:country]}"
        options.delete(:country)
      end

      if options[:city]
        options[:q] += ',' if options[:q]
        options[:q] = "#{options[:q]}#{options[:city]}"
      end

      options
    end
  end
end
