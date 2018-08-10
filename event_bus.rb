class EventBus

  @@subscriptions = []

  def self.subscriptions
    @@subscriptions
  end

  def self.dispatch
  end


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
    @@event_id += 1
    @@event_id
  end


end
