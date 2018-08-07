class EventBus

  def self.subscriptions
    @@subscriptions = []
  end

  def self.dispatch
  end


  ### ID GENERATOR ###
  @@publisher_counter = 0
  @@subscriber_counter = 0


  def self.counters
    [@@publisher_counter, @@subscriber_counter]
  end

  def self.Publisher_ID_Generator
    @@publisher_counter += 1
    return @@publisher_counter
  end

  def self.Subscriber_ID_Generator
    @@subscriber_counter += 1
    return @@subscriber_counter
  end
end
