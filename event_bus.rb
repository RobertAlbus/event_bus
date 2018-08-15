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
    @@buffer = EventBus.event_inbox[0]
  end

  ########
  #   How do I get Ruby to continuously run EventBus.dispatch?
  #   call it in the notify method ???
  ########

  def self.dispatch
    EventBus.buffer_update
    if @@buffer
      ### HOW DO I HANDLE THE ERROR
      ### NO SUBSCRIBERS FOR EVENT && DISPATCH CALLED
      ### RETURNS A BLANK ARRAY, WOULD RATHER IT RETURN
      ### >"No subscribers for this event"
      ### > nil

      #if there's an unprocessed event
      #load first event into buffer
      @@buffer = EventBus.event_inbox.shift
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

          s.event_inbox.push(@@buffer[:payload])
        end
      else
        puts "No Subscribers"
        nil
      end
    else
      puts "Nothing to dispatch"
      nil
    end
  end
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
