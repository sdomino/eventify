# Eventify is a group of properties that when mixed into another object gives that
# object the ability to listen to and fire events in a very simple, clean way.
;Eventify = {

  # assing takes a target object and adds all of Eventify's properties to it turning
  # it into a simple event machine
  assign : (obj) ->

    # iterate over each of Eventify's properties adding them to the desired object
    # unless it already has one
    for k, p of @

      # we'll assume that someone doesn't want their events overriden by default;
      # also, the object has no use for the "assign" method.
      if !obj.hasOwnProperty(p) && k != "assign"
        obj[k] = p

      # just let the user know what a property that eventify uses was found and
      # didn't get overriden. They can change their property if they want to use
      # Eventify
      else console.log "Property '#{k}' not added (already found on object)."

  # the list of registered events
  _events: {}

  # checks if a given [key] is a registered event
  _has_event : (key) -> @._events[key]?

  # checks if a given [handler] is registered on a [key]
  _has_handler : (key, handler) -> @._events[key].indexOf(handler) != -1

  # add event handler unless it's already present
  _add_handler : (key, handler) ->
    @._events[key] ||= []
    @._events[key].push handler unless @_has_handler(key, handler)

  # removes given [handler] from [key]
  _remove_handler: (key, handler) ->
    return unless @_has_event(key) && @_has_handler(key, handler)
    @._events[key].splice(@._events[key].indexOf(handler), 1)

  # registers an event [handler] to a [key]
  on : (key, handler) ->
    return unless key && handler
    @_add_handler(key, handler)
    handler

  # registers an event [handler] to a [key], which once called will be unregistered
  once : (key, handler) ->
    handler_wrapper = =>
      handler?.apply(@, arguments)
      @off(key, handler_wrapper)
    @on(key, handler_wrapper)

  # if [key] and [handler] are provided, unregister [handler] from [key]. If only
  # [key] provided, unregister all [handler]s from [key]. If no arguments provided
  # unregister all events
  off : (key, handler) ->
    if (key && handler) then @_remove_handler(key, handler)
    else if key then delete @._events[key]
    else @._events = {}

  # fire an event by its registered [key]
  fire : (key, data, args...) ->
    return unless @._events[key]
    handler?.apply @, [key, data, args] for handler in @._events[key]
    true

  # if [key] is provided, list all registered [handler]s for [key].
  # If no [key] is provided, list all registered [key]s and corresponding [handler]s
  events : (key) ->
    return @log "Registered Events - ", @._events unless key
    if @_has_event(key) then @._events[key] else @log "Unknown event - ", key
}
