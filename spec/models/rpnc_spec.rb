require 'models/rpn_calculator'

describe RpnCalculator do
  before do
      @rpnc = RpnCalculator.new
  end

  it "should support arithmetic operators" do
    @rpnc.tick("3")
    @rpnc.tick("4")
    @rpnc.tick("+")
    expect(@rpnc.top).to eq 7

    @rpnc.tick("2")
    @rpnc.tick("/")
    expect(@rpnc.top).to eq 3.5

    @rpnc.tick("1.5")
    @rpnc.tick("-")
    expect(@rpnc.top).to eq 2

    @rpnc.tick("4")
    @rpnc.tick("*")
    expect(@rpnc.top).to eq 8
  end

  it "should support a tall stack" do
    @rpnc.tick("19")
    @rpnc.tick("4")
    @rpnc.tick("6")
    @rpnc.tick("3")
    @rpnc.tick("-2")

    @rpnc.tick("*")
    expect(@rpnc.top).to eq -6

    @rpnc.tick("+")
    expect(@rpnc.top).to eq 0

    @rpnc.tick("-")
    expect(@rpnc.top).to eq 4

    @rpnc.tick("*")
    expect(@rpnc.top).to eq 76

    @rpnc.tick("5")
    @rpnc.tick("/")
    expect(@rpnc.top).to eq 15.2
  end
end
