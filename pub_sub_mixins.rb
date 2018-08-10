require 'event_bus'

module EventAgent

  ### ID GENERATOR ###

  attr_accessor :agent_id

  @@agent_id_counter = 0
  def self.agent_id_counter
    @@agent_id_counter
  end

  def new_agent_id
    @agent_id = @@agent_id_counter += 1
  end

  def notify
  end

  def make_subscribable
    #add check for: already subscribable
    EventBus.subscriptions.push({id: @agent_id, subscribers: []})
  end

  def subscribe(publisher_id)
    publisher = EventBus.subscriptions.find { |subscription| subscription[:id] == publisher_id}

    if !publisher
      puts "Event Agent ##{publisher_id} is not subscribable."
      false

    elsif !publisher[:subscribers].include?(@agent_id)
      publisher[:subscribers].push(@agent_id)
      puts "Event Agent ##{@agent_id} is now subcribed to Event Agent ##{publisher_id}"
      true

    elsif publisher[:subscribers].include?(@agent_id)
      puts "Event Agent ##{@agent_id} is already subcribed to Event Agent ##{publisher_id}"
    end
  end

  def unsubscribe(publisher_id)
    unsub_to = EventBus.subscriptions.find { |subscriptions| subscriptions[:id] == publisher_id}
    unsub_to[:subscribers].delete(@agent_id)
    puts "Unsubscribed"
  end



end
