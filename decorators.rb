require './nameable.rb'

class Decorator < Nameable
  def initialize(nameable)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator

  def correct_name
    @nameable.correct_name.split('').map {|item| item.upcase}.join('')
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    @nameable.correct_name.slice(0,9)
  end
end