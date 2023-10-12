class Nameable
  def correct_name
    raise NotImplementedError.new("Method '#{__method__.to_s}' is not implemented for class '#{self.class}'")
  end
end

nameable = Nameable.new
nameable.correct_name