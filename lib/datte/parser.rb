module Datte
  class Parser

    DEFAULT_OPTIONS = {
      locale: 'ja_JP'
    }

    class << self
      attr_writer :locale
      def locale
        @locale || :ja
      end

      attr_writer :default_options
      def default_options
        @default_options ||= DEFAULT_OPTIONS.dup
      end
    end

    def initialize(options = {})
      @options = self.class.default_options.merge(options)
    end

    def parse(body)
      y, m, d = DateParser.new(body).parse
      p y, m, d
    end

    def to_date
      @date
    end
  end
end
