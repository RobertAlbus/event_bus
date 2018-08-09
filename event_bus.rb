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
    return @@event_agent_id
  end
end
