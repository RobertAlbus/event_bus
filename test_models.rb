class A
  include Publisher
  include Subscriber

  def initialize
    new_publisher_id
    new_subscriber_id
  end
end

class B
  include Publisher

  def initialize
    new_publisher_id
  end
end

class C
  include Subscriber

  def initialize
    new_subscriber_id
  end
end
