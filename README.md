## Usage

To turn any object into it's own simple event emitter/handler include Eventify library and "enhance" the object:

```coffeescript

# your object that CANNOT emit/handle events
obj = {}
obj.fire("event") # => obj.fire is not a function

# eventify your object
Eventify.enhance(obj)

# your object that now CAN emit/handle events
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
