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
          break
        end
      end

      ABSOLUTE_TIMES.each do |matcher|
        if md = @body.match(matcher)
          @date.update_time(md)
          p @date
          break
        end
      end

      NOUNS.each do |matcher_s, method|
        matcher = Regexp.new(matcher_s.to_s)
        if md = @body.match(matcher)
          eval(method)
          break
        end
      end

      AFTERS.each do |matcher|
        if md = @body.match(matcher)
          @date.after(md)
          break
        end
      end

      return @date.to_datetime
    end

    private

    def next_day(day)
      now = DateTime.now
      @date.update_date({
        year: now.year,
        month: now.month,
        day: now.day + day
      }, {force_update: true})
    end
  end
end
