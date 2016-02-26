#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__) + "/../"
require 'models/rpn_calculator'

rpnc = RpnCalculator.new

PROMPT = "> "
$stdout.write PROMPT
i = $stdin.gets
while i
  i.chomp!
  break if i == "q"

  rpnc.tick(i)
  $stdout.puts rpnc.last_error if !rpnc.last_error.nil?
  break if rpnc.crashed?

  puts rpnc.top
  $stdout.write PROMPT
  i = $stdin.gets
end
