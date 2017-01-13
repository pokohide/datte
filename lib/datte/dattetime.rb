module Datte
  class Dattetime

    DEFAULT_OPTIONS = {
      force_update: false
    }

    attr_reader :year, :month, :day, :hour, :min, :sec

    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
      @date = Date.today
    end

    def to_s
      @date.to_s
    end

    # 年か月か日を更新
    def update_date(year, month, day)
    end

    # 時か分を更新
    def update_time(hour, min)
    end

    # 何年後、何ヶ月後、何日後
    def after_date(year, month, day)
    end

    # 何時間後、何分後
    def after_time(hour, min)
    end
  end
end
