module EventAgent

  ### ID GENERATOR ###

  attr_accessor :event_inbox

  def new_event_inbox
    @event_inbox = []
  end

  def init_event_agent
    new_event_inbox
  end

  module Publisher

    def notify(payload)
      EventBus.buffer.push(
        Event.new(message = payload, publisher_id = self)
      )
      true
    end

    def make_subscribable

      publisher_exists = EventBus.subscriptions.find { |subscription| subscription[:publisher] == self}

      if publisher_exists
        puts "You're already listed as a publisher"
        false
      else
        EventBus.subscriptions.push( {publisher: self, subscribers: []} )
        true
      end
    end
  end

  module Subscriber

    def subscribe(publisher)
      publisher = EventBus.subscriptions.find { |subscription| subscription[:publisher] == publisher}

      if !publisher
        puts "Not subscribable."
        false

      elsif publisher == self
        puts "Cannot subscribe to yourself"
        false

      elsif publisher[:subscribers].include?(self)
        puts "Already subcribed to this publisher"

      elsif publisher != self
        publisher[:subscribers].push(self)
        puts "Now subcribed to Event Agent ##{publisher}"
        true
      end
    end

    def unsubscribe(publisher_id)
      publisher = EventBus.subscriptions.find { |subscriptions| subscriptions[:id] == publisher_id}
      publisher[:subscribers].delete(self)
      puts "Unsubscribed"
      true
    end

    ### BROKEN TO HERE
    def message(msg)
      @event_log.push(msg)
    end

  end
  include Publisher
  include Subscriber
end
