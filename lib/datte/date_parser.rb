module Datte
  class DateParser

    MATCHER = [
      /(?<year>\d{1,4})\/(?<month>\d{1,2})\/(?<day>\d{1,2})/,
      /(?<month>\d{1,2})\/(?<day>\d{1,2})/
    ].freeze

    def initialize(body, options = {})
      @body = body
      @options = options
    end

    def parse
      MATCHER.each do |matcher|
        @body.match(matcher) do |md|
          @md = md
          return year, month, day
        end
      end
      return nil
    end

    private

    def year
      matched(@md, :year, 2017)
    end

    def month
      matched(@md, :month, 1)
    end

    def day
      matched(@md, :day, 1)
    end

    def matched(md, key, default)
      md.names.include?(key.to_s) ? md[key] : default
    end
  end
end
