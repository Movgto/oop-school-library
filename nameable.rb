class Nameable
  def correct_name
    raise NotImplementedError, "Method '#{__method__}' is not implemented for class '#{self.class}'"
  end
end