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

    def to_datetime
      DateTime.new(@year, @month, @day, 12, 0, 0) rescue nil
    end

    # 年か月か日を更新
    def update_date(md, options = @options)
      op = @options[:force_update] ? '=' : '||='
      eval("@year #{op} year!(md)")
      eval("@month #{op} month!(md)")
      eval("@day #{op} day!(md)")
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

    private
    def now
      d = DateTime.now
      { year: d.year, month: d.month, day: d.day, hour: d.hour, min: d.min }
    end

    def year!(md)
      md.matched?(:year) ? md[:year].to_i : now[:year]
    end

    def month!(md)
      md.matched?(:month) ? md[:month].to_i : now[:month]
    end

    def day!(md)
      md.matched?(:day) ? md[:day].to_i : now[:day]
    end
  end
end

class MatchData
  def matched?(key)
    self.names.include?(key.to_s)
  end
end
