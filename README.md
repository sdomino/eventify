## Usage

To turn any object into it's own simple event emitter/handler include the javascript library and "assign" Eventify to an object:

```coffeescript

# your object that CANNOT emit/handle
obj = {}
obj.fire("event") # => obj.fire is not a function

# eventify your object
Eventify.assign(obj)

# your object that now CAN emit/handle events
obj.on("event", () -> console.log("event!"))
obj.fire("event", data)
# => event!
```

## Options

```coffeescript
on()      # register and handle an event
once()    # handle an event only once
off()     # unregister an event
fire()    # fire an event
events()  # shows all registered events
```
