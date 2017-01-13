module Datte
  class DateParser
    def initialize(body, options = {})
      @body = body
      @options = options
      @date = Dattetime.new
    end

    def parse
      ABSOLUTE_DATES.each do |matcher|
        if md = @body.match(matcher)
          @date.update_date(md)
          p @date
          p @date.year
          p @date.month
          p @date.day
          p md
          break
        end
      end

      return @date.to_datetime

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

  end
end
