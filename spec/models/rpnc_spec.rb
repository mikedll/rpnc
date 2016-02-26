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

  it "should use floating point division" do
    @rpnc.tick("3")
    @rpnc.tick("2")
    @rpnc.tick("/")
    expect(@rpnc.top).to eq 1.5
  end

  it "tolerate leading and trailing whitespace" do
    @rpnc.tick("  6   ")
    @rpnc.tick("4   ")
    @rpnc.tick("  -2")
    @rpnc.tick("/")
    @rpnc.tick("+")
    expect(@rpnc.top).to eq 4
  end

  it "support decimal inputs" do
    @rpnc.tick("4.4")
    @rpnc.tick("-2.3")
    @rpnc.tick("*")
    expect(@rpnc.top).to eq -10.12
  end

  it "should truncate results when possible" do
    @rpnc.tick("4.0")
    @rpnc.tick("2.0")
    @rpnc.tick("/")
    expect(@rpnc.top.to_s).to eq "2"
  end

  it "should round to two points of precision with non-integer results" do
    @rpnc.tick("10.00001")
    expect(@rpnc.top).to eq 10.0

    @rpnc.tick("3")
    @rpnc.tick("/")
    expect(@rpnc.top).to eq 3.33
  end

  context "error handling" do
    it "should handle division by zero" do
      @rpnc.tick("1")
      @rpnc.tick("3")
      @rpnc.tick("4")
      @rpnc.tick("1")
      @rpnc.tick("-")
      @rpnc.tick("-")
      @rpnc.tick("/")
      expect(@rpnc.last_error).to eq RpnCalculator::Errors::DIVISION_BY_ZERO
    end

    it "should handle unrecognized input" do
      @rpnc.tick(" &&&&&&&&&&&&&&&&&&&&&&&")
      expect(@rpnc.last_error).to eq (RpnCalculator::Errors::UNRECOGNZIED_INPUT % " &&&&&&&&&&&&&&&&&&&&&&&")
    end

    it "should recognize premature operator invocation" do
      @rpnc.tick("4")
      @rpnc.tick("/")
      expect(@rpnc.last_error).to eq RpnCalculator::Errors::PREMATURE_OPERATOR
    end
  end
end
