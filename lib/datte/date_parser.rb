module Datte
  class DateParser
    def initialize(body, options = {})
      @body = body
      @options = options
      @date = nil
      #p Date.today
      #p Dattetime.new().to_s
    end

    def parse
      ABSOLUTE_DATES.each do |matcher|
        @body.match(matcher) do |md|
          p md
          break
        end
      end

      return Date.today

      # MATCHER.each do |matcher|
      #   @body.match(matcher) do |md|
      #     y = year(md)
      #     m = month(md)
      #     d = day(md)
      #     #h = hour(md)
      #     #m = minute(md)
      #
      #     @md = md
      #     return y, m, d
      #   end
      # end
    end

    private

    def year
      @year ||= matched(@md, :year, Date.today.year)
    end

    def month
      @month ||= matched(@md, :month, Date.today.month)
    end

    def day
      @day ||= matched(@md, :day, Date.today.day)
    end

    def matched(md, key, default)
      md.names.include?(key.to_s) ? md[key] : default
    end
  end
end
