# EventBus
### this is a project to experiment with the publisher-subscriber pattern. The key difference between publisher-subscriber and the observer pattern is that in pub-sub the publishers are not concerned with who is subscribed to their messages. This concern is placed upon a handler in between the publisher and subscriber.

## Publisher
An object who is concerned with alerting others about some sort of event. 

## Subscriber
An object who is concerned with receiving alerts about some sort of event.

## Event Bus
An object designed to facilitate the dilevery of events from a publisher to a subscriber. Event Bus maintains a list of which objects are subscribable and subsequently the subscribers to such objects.

## Event
An object with an ID number and a payload. Created by a publisher, handed to the EventBus, and delivered to each subscriber.

## EventAgent
The class containing functionality for publishers and subscribers. 
