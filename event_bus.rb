class EventBus

  @@subscriptions = []

  def self.subscriptions
    @@subscriptions
  end

  def self.dispatch
  end

  ### ID GENERATOR ###
  @@event_agent_id = 0
  def self.event_agent_id
    @@event_agent_id
  end
  #

  def self.event_agent_id_generator
    @@event_agent_id += 1
    @@event_agent_id
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
  @@event_id = 0
  def self.event_id_generator
    @@event_id += 1
    @@event_id
  end


end
