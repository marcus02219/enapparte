angular
  .module 'enapparte'
  .service 'Flash', ['notify',
    class Flash
      constructor: (@notify)->

      showNotice: (scope, msg)->
        @notify
          message: msg
      showSuccess: (scope, msg)->
        @notify
          classes: 'alert-success'
          message: msg
      showError: (scope, msg)=>
        @notify
          classes: 'alert-danger'
          message: msg
      closeNotice: ()->
  ]
