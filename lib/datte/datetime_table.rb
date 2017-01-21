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

  NOUNS = {
    '明日|あした|あす': 'send(:next_day, 1)',
    '明後日|あさって': 'send(:next_day, 2)',
    '明々後日|しあさって': 'send(:next_day, 3)',
    '今日|きょう': 'send(:next_day, 0)'
  }

  AFTERS = [
    # 何年後
    '(?<year>\d{1)年後',
    # 何ヶ月後
    '(?<month>\d{1,2}ヶ月後)',
    # 何日後
    '(?<day>\d{1,2})日後',
    # 何時間後
    '(?<hour>\d{1,2})時間後',
    # 何分後
    '(?<min>\d{1,2})分後'
  ].map { |pattern| Regexp.compile(pattern) }.freeze

  WEEKS = {
    '来週|らいしゅう': 1,
    '再来週|さらいしゅう': 2,
    '次の': 1,
    '翌週': 1
  }

  WDAYS = {
    '日曜日|にちようび|日曜': 0,
    '月曜日|げつようび|月曜': 1,
    '火曜日|かようび|火曜': 2,
    '水曜日|すいようび|水曜': 3,
    '木曜日|もくようび|木曜': 4,
    '金曜日|きんようび|金曜': 5,
    '土曜日|どようび|土曜': 6
  }

  class DatetimeTable
    def initialize
    end
  end
end
