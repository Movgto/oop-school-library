class Nameable
  def correct_name
    raise NotImplementedError.new("Method '#{__method__.to_s}' is not implemented for class '#{self.class}'")
  end
end
<<<<<<< HEAD
=======

nameable = Nameable.new
nameable.correct_name
>>>>>>> parent of 6c183b5 (Fix linters)
