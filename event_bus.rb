class EventBus

  # class variables and accessors
  @@subscriptions = []
  @@event_inbox = []
  @@buffer = {}
  def self.event_inbox
    @@event_inbox
  end

  def self.subscriptions
    @@subscriptions
  end

  def self.buffer
    @@buffer
  end

  def self.buffer_update
    if EventBus.event_inbox[0]
      @@buffer = EventBus.event_inbox.shift
    end
  end

  def self.buffer_flush
    @@buffer = {}
  end

  ########
  #   How do I get Ruby to continuously run EventBus.dispatch?
  #   call it in the notify method ???
  ########

  def self.dispatch
    self.buffer_update
    if @@buffer
      ### HOW DO I HANDLE THE ERROR
      ### NO SUBSCRIBERS FOR EVENT && DISPATCH CALLED
      ### RETURNS A BLANK ARRAY, WOULD RATHER IT RETURN
      ### > nil

      #get pushlisher of this payload
      this_publisher = @@buffer.payload[:publisher]
      #get matching subscription list
      this_subscription = EventBus.subscriptions.find{|subscription| subscription[:publisher] == this_publisher}

      if this_subscription[:subscribers]
        this_subscription[:subscribers].each do |s|

          ###
          # What exactly do I want to put in the subscribers inbox?
          # The whole event or just the payload?
          ###

          s.event_inbox.push(@@buffer.payload)
        end
      else
        # Why doesnt this happen?
        puts "No Subscribers"
        nil
      end

      self.buffer_flush
      return
      # else
      #   puts "Nothing to dispatch"
      #   nil
    end
  end

  def self.start_dispatcher
    Thread.new {
      loop do
        if @@event_inbox[0]

          self.dispatch
          sleep(10)
        end
      end
    }
  end

  self.start_dispatcher
end

class Event

  attr_accessor :payload



  def initialize( message = 0, publisher_id = self)
    @payload = {
      publisher: publisher_id,
      event_id: Event.id_generator,
      message: message
    }
  end

  ### ID GENERATOR
  @@event_id_counter = 0
  def self.id_generator
    @@event_id_counter  += 1
    @@event_id_counter
  end

end
