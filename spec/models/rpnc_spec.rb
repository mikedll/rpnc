

require 'models/rpn_calculator'

describe RpnCalculator do
  before do
      @rpnc = RpnCalculator.new
  end

  it "should support arithmatic operators", :focus => true do
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
end
