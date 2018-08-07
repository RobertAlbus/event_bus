require 'event_bus'

module Publisher
  def new_publisher_id
    @publisher_id = EventBus.Publisher_ID_Generator
  end

  def notify
  end
end

module Subscriber

  def new_subscriber_id
    @subscriber_id = EventBus.Subscriber_ID_Generator
  end

  def subscribe
  end

  def unsubscribe
  end
end
