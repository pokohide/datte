module Datte
  class TextConverter

    KANNUM_ALL = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '百', '千']
    KANNUM_1_9 = { ''=>1, '一'=>1, '二'=>2, '三'=>3, '四'=>4, '五'=>5, '六'=>6, '七'=>7, '八'=>8, '九'=>9 }
    KANNUM_10 = {'千'=>1000, '百'=>100, '十'=>10, ''=>1 }

    def initialize(options = {})
      @options = options
    end

    def kan_num(body)
      body.scan(/[#{KANNUM_ALL.join('')}]+/).each do |kan|
        num = kan.scan(/([^千百十]*)([千百十]?)/).inject(-1) do |num, (_1_9, unit)|
          num + KANNUM_1_9[_1_9] * KANNUM_10[unit]
        end
        body.gsub!(kan, num.to_s)
      end
      body
    end
  end
end
