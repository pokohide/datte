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

      WEEKS.each do |matcher_s, week|
        matcher = Regexp.new(matcher_s.to_s)
        if @body.match(matcher)
          WDAYS.each do |wday_matcher_s, wday|
            wday_matcher = Regexp.new(wday_matcher_s.to_s)
            if @body.match(wday_matcher)
              now_wday = DateTime.now.wday
              day = 7 * (week || 1) + wday - now_wday
              @date.after({day: day})
            end
          end
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
