var Eventify,
  slice = [].slice;

Eventify = {
  assign: function(obj) {
    var k, p, results;
    results = [];
    for (k in this) {
      p = this[k];
      if (!obj.hasOwnProperty(p) && k !== "assign") {
        results.push(obj[k] = p);
      } else {
        results.push(console.log("Property '" + k + "' not added (already found on object)."));
      }
    }
    return results;
  },
  _events: {},
  _has_event: function(key) {
    return this._events[key] != null;
  },
  _has_handler: function(key, handler) {
    return this._events[key].indexOf(handler) !== -1;
  },
  _add_handler: function(key, handler) {
    var base;
    (base = this._events)[key] || (base[key] = []);
    if (!this._has_handler(key, handler)) {
      return this._events[key].push(handler);
    }
  },
  _remove_handler: function(key, handler) {
    if (!(this._has_event(key) && this._has_handler(key, handler))) {
      return;
    }
    return this._events[key].splice(this._events[key].indexOf(handler), 1);
  },
  on: function(key, handler) {
    if (!(key && handler)) {
      return;
    }
    this._add_handler(key, handler);
    return handler;
  },
  once: function(key, handler) {
    var handler_wrapper;
    handler_wrapper = (function(_this) {
      return function() {
        if (handler != null) {
          handler.apply(_this, arguments);
        }
        return _this.off(key, handler_wrapper);
      };
    })(this);
    return this.on(key, handler_wrapper);
  },
  off: function(key, handler) {
    if (key && handler) {
      return this._remove_handler(key, handler);
    } else if (key) {
      return delete this._events[key];
    } else {
      return this._events = {};
    }
  },
  fire: function() {
    var args, data, handler, i, key, len, ref;
    key = arguments[0], data = arguments[1], args = 3 <= arguments.length ? slice.call(arguments, 2) : [];
    if (!this._events[key]) {
      return;
    }
    ref = this._events[key];
    for (i = 0, len = ref.length; i < len; i++) {
      handler = ref[i];
      if (handler != null) {
        handler.apply(this, [key, data, args]);
      }
    }
    return true;
  },
  events: function(key) {
    if (!key) {
      return this.log("Registered Events - ", this._events);
    }
    if (this._has_event(key)) {
      return this._events[key];
    } else {
      return this.log("Unknown event - ", key);
    }
  }
};
