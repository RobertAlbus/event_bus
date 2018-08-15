class A
  include EventAgent
  def initialize
    init_event_agent
    make_subscribable
    #notify "hello"
  end
end

class S
  include EventAgent
  def initialize
    init_event_agent

  end
end

class E < Event
end
