class RpnCalculator

  def initialize
    @crashed = false
    @stack = []
  end

  def crashed?; @crashed; end

  #
  # Moves the state of the calculator on step
  # based on input i.
  #
  def tick(i)
    if i =~ /\A(\d+(\.\d+)?)\z/
      @stack.push($1.to_f)
    elsif ["*", "+", "-", "/"].include?(i)
      if @stack.length < 2
        puts "Cannot invoke an operator without at least two operands on the RPN Calculator stack."
      else
        r = @stack.pop
        l = @stack.pop
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

        if n.nil?
          @crashed = true
        else
          puts n
          @stack.push(n)
        end

      end
    else
      puts "Unrecognized input: #{i}"
    end
  end

  def top
    @stack.last
  end


end
