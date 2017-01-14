require "spec_helper"

describe Datte do
  it "has a version number" do
    expect(Datte::VERSION).not_to be nil
  end

  describe "::Parser" do
    datte = Datte::Parser.new

    it "2016/11/1日に遊ぼー" do
      body = "2016/11/1日に遊ぼー"
      d = DateTime.now
      expect(datte.parse_date(body)).to eq(DateTime.new(2016, 11, 1, d.hour, 0, 0))
    end
  end
end
