class A
  include Publisher
  include Subscriber

  def initialize
  end
end

class B
  include Publisher

  def initialize
  end
end

class C
  include Subscriber

  def initialize
  end
end
