module Datte
  class Dattetime

    DEFAULT_OPTIONS = {
      force_update: false,
      level: 1
    }

    attr_reader :year, :month, :day, :hour, :min

    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
      @date = DateTime.now
    end

    def to_datetime
      return nil unless check_level?
      DateTime.new(y, m, d, h, mi, 0) rescue nil
    end

    # 年か月か日を更新
    def update_date(md, options = @options)
      op = @options[:force_update] ? '=' : '||='
      eval("@year #{op} year!(md)")
      eval("@month #{op} month!(md)")
      eval("@day #{op} day!(md)")
    end

    # 時か分を更新
    def update_time(md, options = @options)
      op = @options[:force_update] ? '=' : '||='
      eval("@hour #{op} hour!(md)")
      eval("@min #{op} min!(md)")
    end

    # 何年後、何ヶ月後、何日後, 何時間後, 何分後
    def after(md)
      @date >> (md[:year].to_i * 12) if md.matched?(:year) # 何年後
      @date >> md[:month].to_i if md.matched?(:month) # 何ヶ月後
      @date + md[:day].to_i if md.matched?(:day) # 何日後
      @date + Rational(md[:hour].to_i, 24) # 何時間後
      @date + Rational(md[:hour].to_i, 24 * 60) # 何分後
    end

    private

    def y; @year || now[:year] end
    def m; @month || now[:month] end
    def d; @day || now[:day] end
    def h; @hour || now[:hour] end
    def mi; @min || 0 end

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

    def hour!(md)
      md.matched?(:hour) ? md[:hour].to_i : now[:hour]
    end

    def min!(md)
      md.matched?(:min) ? md[:min].to_i : 0
    end

    def check_level?
      counter = 0
      [@year, @month, @day, @hour, @min].each do |check|
        counter += 1 unless check.nil?
      end
      @options[:level] < counter
    end
  end
end

class MatchData
  def matched?(key)
    self.names.include?(key.to_s)
  end
end
