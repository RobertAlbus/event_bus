require 'event_bus'

module Publisher
  def new_publisher_id
    @publisher_id = EventBus.Publisher_ID_Generator
    make_subscribable
  end

  def notify
  end

  def make_subscribable
    EventBus.subscriptions.push({id: @publisher_id, subscribers: []})
  end

end

module Subscriber

  def new_subscriber_id
    @subscriber_id = EventBus.Subscriber_ID_Generator
  end

  def subscribe(publisher_id)
    sub_to = EventBus.subscriptions.find { |subscriptions| subscriptions[:id] == publisher_id}
    sub_to[:subscribers].push(@subscriber_id)
  end

  def unsubscribe(publisher_id)
    unsub_to = EventBus.subscriptions.find { |subscriptions| subscriptions[:id] == publisher_id}
    unsub_to[:subscribers].delete(@subscriber_id)
    puts "Unsubscribed"
  end



end
