

module EventAgent

  ### ID GENERATOR ###

  attr_accessor :agent_id
  attr_accessor :event_inbox

  @@agent_id_counter = 0
  def self.agent_id_counter
    @@agent_id_counter
  end

  def new_agent_id
    @agent_id = @@agent_id_counter += 1
  end

  def new_event_inbox
    @event_inbox = []
  end

  def init_event_agent
    new_agent_id
    new_event_inbox
  end


  module Publisher

    def notify(payload)



      EventBus.buffer.push(
        Event.new(message = payload, publisher_id = @agent_id)
      )
      true
      # if payload.instance_of? Event
      # else
      #   puts "Invalid payload. Please use an Event object"
      #   false
      # end
    end

    def make_subscribable

      publisher_exists = EventBus.subscriptions.find { |subscription| subscription[:id] == @agent_id}

      if publisher_exists
        puts "You're already listed as a publisher"
        false
      else
        EventBus.subscriptions.push( {id: @agent_id, subscribers: []} )
        true
      end
    end

  end

  module Subscriber

    def subscribe(publisher_id)
      publisher = EventBus.subscriptions.find { |subscription| subscription[:id] == publisher_id}

      if !publisher
        puts "Event Agent ##{publisher_id} is not subscribable."
        false

      elsif publisher_id == @agent_id
        puts "Cannot subscribe to yourself"
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
      publisher = EventBus.subscriptions.find { |subscriptions| subscriptions[:id] == publisher_id}
      publisher[:subscribers].delete(@agent_id)
      puts "Unsubscribed"
      true
    end


    def message(msg)
      @event_log.push(msg)
    end

  end

  include Publisher
  include Subscriber
end
