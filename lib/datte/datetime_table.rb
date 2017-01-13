module Datte

  MATCHER = [
    /(?<year>\d{1,4})\/(?<month>\d{1,2})\/(?<day>\d{1,2})/,
    /(?<month>\d{1,2})\/(?<day>\d{1,2})/
  ].freeze

  ABSOLUTE_DATES = [
    # <year>-<month>-<day>
    '(?<year>\d{1,4})-(?<month>\d{1,2})-(?<day>\d{1,2})',
    # <year>/<month>/<day>
    '(?<year>\d{1,4})\/(?<month>\d{1,2})\/(?<day>\d{1,2})',
    # <year>年<month>月<day>日
    '(?<year>\d{1,4})年(?<month>\d{1,2})月(?<day>\d{1,2})日',
    # <month>-<day>
    '(?<month>\d{1,2})-(?<day>\d{1,2})',
    # <month>/<day>
    '(?<month>\d{1,2})\/(?<day>\d{1,2})',
    # <month>月<day>日
    '(?<month>\d{1,2})月(?<day>\d{1,2})日',
    # <month>月
    '(?<month>\d{1,2})月',
    # <day>日
    '(?<day>\d{1,2})日'
  ].map { |pattern| Regexp.compile(pattern) }.freeze

  ABSOLUTE_TIMES = [
    # <hour>-<min>
    '(?<hour>\d{1,2})-(?<min>\d{1,2})',
    # <hour>:<min>
    '(?<hour>\d{1,2}):(?<min>\d{1,2})',
    # <hour>時<min>分,
    '(?<hour>\d{1,2})時(?<min>\d{1,2})分',
    # <hour>時
    '(?<hour>\d{1,2})時',
    # <min>分
    '(?<min>\d{1,2})分'
  ].map { |pattern| Regexp.compile(pattern) }.freeze

  # DATES = {
  #   '明日|あした': 'send(:next_day, 1)',
  #   '明後日|あさって': 'send(:next_day, 2)',
  #   '': '',
  # }

  # TIMES = {
  #   '(?<hour>\d{1,2})時(?<min>\d{1,2})分',
  #   '(?<hour>\d{1,2})時',
  #   ''
  # }

  class DatetimeTable
    def initialize
    end
  end
end
