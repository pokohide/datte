require "spec_helper"

describe Datte::Parser do
  parser = Datte::Parser.new
  d = DateTime.now

  it "日時情報を含まなければnilを返す" do
    body = "ChatBotHack楽しい"
    expect(parser.parse_date(body)).to eq(nil)

    body = "お腹すいたなぁ"
    expect(parser.parse_date(body)).to eq(nil)
  end


  it "y/m/d 形式での認識" do
    body = "2016/11/1日に遊ぼー"
    expect(parser.parse_date(body)).to eq(DateTime.new(2016, 11, 1, d.hour, 0, 0))

    body = "8/10日に飲みに行かない？"
    expect(parser.parse_date(body)).to eq(DateTime.new(d.year, 8, 10, d.hour, 0, 0))
  end

  it "何時何分のような時間の認識" do
    body = "明日の朝8時集合ね!"
    expect(parser.parse_date(body).day).to eq((d+1).day)
    expect(parser.parse_date(body).hour).to eq(8)

    body = "20日の16時集合ね!"
    expect(parser.parse_date(body).day).to eq(20)
    expect(parser.parse_date(body).hour).to eq(16)
  end

  it "明日や明後日といった相対的な文字の認識" do
    body = "明日テストだ。。。"
    expect(parser.parse_date(body).day).to eq((d+1).day)

    body = "でも明後日はお肉食べに行く"
    expect(parser.parse_date(body).day).to eq((d+2).day)
  end

  # TODO この部分のテスト通らないので本体を修正
  it "3日後のような相対的な数値" do
    body = "もう3日後にはセンター試験"
    expect(parser.parse_date(body).day).to eq((d+3).day)

    body = "今日の一時間後に卓球しない？"
    expect(parser.parse_date(body).hour).to eq((d+Rational(1, 24)).hour)
  end
end
