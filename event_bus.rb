class EventBus

  ########
  # subscriptions
  ####

  @@subscriptions = []
  def self.subscriptions
    @@subscriptions
  end

  ########
  # receive
  ####

  @@event_inbox = []
  def self.event_inbox
    @@event_inbox
  end

  def self.receive(msg)
    EventBus.event_inbox.push(msg)
  end

  ########
  # buffer
  ####

  @@buffer = {}
  def self.buffer
    @@buffer
  end

  def self.buffer_update
    if self.event_inbox[0]
      @@buffer = self.event_inbox.shift
    end
  end

  def self.buffer_flush
    @@buffer = {}
  end

  ########
  # dispatch
  ####

  def self.dispatch_thread
    @@dispatch_thread.status
  end

  def self.dispatch
    self.buffer_update
    if @@buffer

      #get pushlisher of this payload
      this_publisher = @@buffer.payload[:publisher]

      #get matching subscription list
      this_subscription = self.subscriptions.find{|subscription| subscription[:publisher] == this_publisher}

      if this_subscription[:subscribers]
        this_subscription[:subscribers].each do |subscriber|
          subscriber.event_inbox.push(@@buffer.payload)
        end
      end

      self.buffer_flush
      return
    end
  end

  def self.start_dispatcher
    @@dispatch_thread = Thread.new {
      loop do
        if @@event_inbox[0]
          self.dispatch
          sleep(10)
        end
      end
    }
  end

  def self.stop_dispatcher
    @@dispatch_thread.exit
    sleep(0.1) # need to wait to return correct value.
    self.dispatch_thread
  end

  ########
  # end EventAgent
  ####
end

class Event

  attr_accessor :payload

  def initialize( message = 0, publisher = self)
    @payload = {
      publisher: publisher,
      event_id: Event.id_generator,
      message: message
    }
  end

  ########
  # id generator
  ####

  @@event_id_counter = 0
  def self.id_generator
    @@event_id_counter  += 1
    @@event_id_counter
  end

end
