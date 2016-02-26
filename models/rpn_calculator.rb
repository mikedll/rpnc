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
    if i =~ /\A\s*(-?\d+(\.\d+)?)\s*\z/
      n = $1.to_f
      @stack.push(_clean(n))
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
                l.to_f / r.to_f
              end
            else
              puts "Programming error: Operator not implemented #{i}."
              nil
            end

        if n.nil?
          @crashed = true
        else
          @stack.push(_clean(n))
        end
      end
    else
      puts "Unrecognized input: #{i}"
    end
  end

  def top
    @stack.last
  end

  private

  def _clean(n)
    n == n.truncate ? n.truncate : n.round(2)
  end


end
