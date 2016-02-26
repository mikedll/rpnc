#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__) + "/../"
require 'models/rpn_calculator'

rpnc = RpnCalculator.new
i = $stdin.gets
while i
  i.chomp!
  break if i == "q"

  rpnc.tick(i)

  break if rpnc.crashed?

  i = $stdin.gets
end
