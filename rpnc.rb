#!/usr/bin/env ruby

s = []

i = $stdin.gets
while i
  i.chomp!
  break if i == "q"

  if i =~ /\A(\d+(\.\d+)?)\z/
    s.push($1.to_f)
  elsif ["*", "+", "-", "/"].include?(i)
    if s.length < 2
      puts "Cannot invoke an operator without at least two operands on the RPN Calculator stack."
    else
      r = s.pop
      l = s.pop
      n = case i
          when "*"; l * r
          when "+"; l + r
          when "-"; l - r
          when "/"
            if r == 0
              puts "Cannot divide by zero."
              nil
            else
              l / r
            end
          else
            raise "Operator not implemented #{i}."
          end

      break if n.nil?

      puts n
      s.push(n)
    end
  else
    puts "Unrecognized input: #{i}"
  end

  i = $stdin.gets
  i.chomp!
end
