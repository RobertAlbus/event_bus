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

  # if @@buffer[0]
  #   # share payload with subscribers
  # end
end

class Event

  attr_accessor :payload

  def initialize( message = 0 )
    @payload = {
      id: Event.event_id_generator,
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
