## Basic Usage

To turn any object into it's own simple event emitter/handler include Eventify library and "enhance" the object:

```coffeescript

obj = {}
obj.fire("event")
# => obj.fire is not a function

Eventify.extend(obj)

obj.on("event", () -> console.log("event!"))
obj.fire("event", data)
# => event!
```

## Properties

```coffeescript
on()      # register and handle an event
once()    # handle an event only once
off()     # unregister an event
fire()    # fire an event
events()  # shows all registered events
```

## Using Eventify

If you don't want to turn any specific object into an event emitter/handler but instead just want to emit/handle events globally you can simply use Eventify itself

``` coffeescript

Eventify.fire()
# => Uncaught TypeError: Cannot read property 'event!' of undefined

# init eventify to be a generic event handler/emitter
Eventify.init()
Eventify.fire("event!")
# => event!
```
