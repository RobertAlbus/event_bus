class EventBus


  # class variables and accessors
  @@subscriptions = []
  @@buffer = []

  def self.buffer
    @@buffer
  end

  def self.subscriptions
    @@subscriptions
  end

  while @@buffer[0]
    #push to subscribers
    #buffer[0].delete
  end
end

class Event

  attr_accessor :payload

  def initialize( message = 0, publisher_id = @agent_id)
    @payload = {
      publisher_id: publisher_id,
      event_id: Event.event_id_generator,
      message: message
    }
  end

  ### ID GENERATOR
  @@event_id_counter = 0
  def self.event_id_generator
    @@event_id_counter  += 1
    @@event_id_counter
  end

end
