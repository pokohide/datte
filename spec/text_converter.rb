require 'spec_helper'

describe Datte::TextConverter do
  tc = Datte::TextConverter.new()

  it '漢数字を数字に変換' do
    expect(tc.kan_num('一月二日')).to eq '1月2日'
    expect(tc.kan_num('十二月二十日に遊びに行こうね！')).to eq '12月20日に遊びに行こうね！'
    expect(tc.kan_num('今日の一時間後くらいに飲みに行かない？')).to eq '今日の1時間後くらいに飲みに行かない？'
  end

  it '漢数字がなければ何もしない' do
    expect(tc.kan_num('おなかすいた')).to eq 'おなかすいた'
    expect(tc.kan_num('今日は夕ご飯食べるの?')).to eq '今日は夕ご飯食べるの?'
    expect(tc.kan_num('就活で消耗してる。。。')).to eq '就活で消耗してる。。。'
  end
end
