class RpnCalculator

  module Errors
    PREMATURE_OPERATOR = "Cannot invoke an operator without at least two operands on the RPN Calculator stack."
    DIVISION_BY_ZERO = "Cannot divide by zero."
    UNRECOGNZIED_INPUT = "Unrecognized input: %s"
    OPERATOR_NOT_IMPLEMENTED = "Programming error: Operator not implemented %s."
  end

  attr_accessor :last_error

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
    self.last_error = nil

    if i =~ /\A\s*(-?\d+(\.\d+)?)\s*\z/

      # We may use BigDecimal or advanced decimal fraction
      # parsing at this point of the code in the future,
      # as needed by the application's requirements.
      n = $1.to_f

      @stack.push(_clean(n))
    elsif ["*", "+", "-", "/"].include?(i)
      if @stack.length < 2
        self.last_error = Errors::PREMATURE_OPERATOR
      else
        r = @stack.pop
        l = @stack.pop
        n = case i
            when "*"; l * r
            when "+"; l + r
            when "-"; l - r
            when "/"
              if r == 0
                self.last_error = Errors::DIVISION_BY_ZERO
                nil
              else
                l.to_f / r.to_f
              end
            else
              self.last_error = (Errors::OPERATOR_NOT_IMPLEMENTED % i)
              nil
            end

        if n.nil?
          @crashed = true
        else
          @stack.push(_clean(n))
        end
      end
    else
      self.last_error = (Errors::UNRECOGNZIED_INPUT % i)
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
