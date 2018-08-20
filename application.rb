require 'event_bus'
require 'pub_sub_mixins'
require 'test_models'
EventBus.start_dispatcher


#make Publisher.event_inbox not show up in the delivered payload
#because this is messy when looking at Subscriber
#maybe some core function in ruby for listing object ID instead of passing whole object
#IE Object.object_id ??

#create stub function for Subscriber.do_something_with_new_message
