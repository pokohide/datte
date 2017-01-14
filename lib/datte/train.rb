module Datte
  class Train
    FNAME = File.join(File.dirname(__FILE__), 'data.txt')

    # SEE: http://qiita.com/Hironsan/items/326b66711eb4196aa9d4

    def initialize(path = FNAME)
      train_sents = corpus_read
      x = corpus_read[0]
      p x
      p '==='
      p sent2features(x)
      #sent2features(corpus_read[0])[0]
      #sent2features(train_sents[0])[0]
    end

    def x_train
      train_sents.each do |s|
        return sent2features(s)
      end
    end

    def y_train
      train_sents.each do |s|
        return sent2labels(s)
      end
    end

    def x_test
      test_sents.each do |s|
        return sent2features(s)
      end
    end

    def y_test
      test_sents.each do |s|
        return sent2labels(s)
      end
    end

    def train()
    end

    private
    def hiragana?(ch)
      0x3040 <= ch.ord && ch.ord <= 0x309F
    end

    def katakana(ch)
      0x30A0 <= ch.ord && ch.ord <= 0x30FF
    end

    def space?(ch)
      !(ch =~ /^\s*$/).nil?
    end

    def integer?(ch)
      Integer(ch)
      Integer(ch)
      true
    rescue ArgumentError
      false
    end

    def lower?(ch)
      ch == ch.downcase
    end

    def upper?(ch)
      ch == ch.upcase
    end

    def chara_type(ch)
      if space?(ch) then 'ZSPACE'
      elsif integer?(ch) then 'ZDIGIT'
      elsif lower?(ch) then 'ZLLET'
      elsif upper?(ch) then 'ZULET'
      elsif hiragana?(ch) then 'HIRAG'
      elsif katakana?(ch) then 'KATAK'
      else 'OTHER'
      end
    end

    def chara_types(str)
      types = str.each_char.to_a.map do |ch|
        chara_type(ch)
      end
      types.uniq.sort().join('-')
    end

    def extract_pos(morph)
      idx = morph.index('*')
      morph[1, idx-1].join('-')
    end

    def word2features(sent, i)
      word = sent[i][0]
      chtype = chara_types(sent[i][0])
      postag = extract_pos(sent[i])

      features = [
        'bias',
        'word=' + word,
        'type=' + chtype,
        'pos_tag=' + postag
      ]

      if i >= 2
        word2 = sent[i-2][0]
        chtype2 = chara_types(sent[i-2][0])
        postag2 = extract_pos(sent[i-2])
        iobtag2 = sent[i-2][-1]
        features.push(*[
          '-2:word=' + word2,
          '-2:type=' + chtype2,
          '-2:postag=' + postag2,
          '-2:iobtag=' + iobtag2
        ])
      else
        features.push('BOS')
      end

      if i >= 1
        word1 = sent[i-1][0]
        chtype1 = chara_types(sent[i-1][0])
        postag1 = extract_pos(sent[i-1])
        iobtag1 = sent[i-1][-1]
        features.push(*[
          '-1:word=' + word1,
          '-1:type=' + chtype1,
          '-1:postag=' + postag1,
          '-1:iobtag=' + iobtag1
        ])
      else
        features.push('BOS')
      end

      if i < sent.length - 1
        word1 = sent[i+1][0]
        chtype1 = chara_types(sent[i+1][0])
        postag1 = extract_pos(sent[i+1])
        features.push(*[
          '+1:word=' + word1,
          '+1:type=' + chtype1,
          '+1:postag=' + postag1
        ])
      else
        features.push('EOS')
      end

      if i < sent.length - 2
        word2 = sent[i+2][0]
        chtype2 = chara_types(sent[i+2][0])
        postag2 = extract_pos(sent[i+2])
        features.push(*[
          '+2:word=' + word2,
          '+2:type=' + chtype2,
          '+2:postag=' + postag2
        ])
      else
        features.push('EOS')
      end

      return features
    end

    def sent2features(sent)
      (0..(sent.length)).to_a.map do |i|
        return word2features(sent, i)
      end
    end

    def sent2labels(sent)
      sent.map do |morph|
        morph[-1]
      end
    end

    def sent2tokens(sent)
      sent.map do |morph|
        morph[0]
      end
    end

    def corpus_read
      sents, sent = [], []

      File.open(FNAME, 'r') do |file|
        file.each_line do |line|
          if line == "\n"
            sents.push(sent)
            sent = []
            next
          end
          morph_info = line.strip().split(' ')
          sent.push(morph_info)
        end
      end
      sents
    end

  end
end
