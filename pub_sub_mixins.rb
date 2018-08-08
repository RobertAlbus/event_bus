require 'event_bus'

module Publisher
  def new_publisher_id
    @publisher_id = EventBus.Publisher_ID_Generator
    make_subscribable
  end

  def notify
  end

  def make_subscribable
    EventBus.subscriptions.push([@publisher_id])
  end

end

module Subscriber

  def new_subscriber_id
    @subscriber_id = EventBus.Subscriber_ID_Generator
  end

  def subscribe(publisher_id)

    EventBus.subscriptions[publisher_id - 1].push(@subscriber_id)
  end

  def unsubscribe
  end
end
