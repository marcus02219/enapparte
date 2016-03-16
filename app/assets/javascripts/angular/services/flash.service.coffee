angular
  .module 'enapparte'
  .service 'Flash', ['notify',
    class Flash
      constructor: (@notify)->

      showNotice: (scope, msg)->
        @notify
          messageTemplate: '<span>' + msg + '</span>'
          scope: scope

      showSuccess: (scope, msg)->
        @notify
          classes: 'alert-success'
          messageTemplate: '<span>' + msg + '</span>'
          scope: scope

      showError: (scope, msg)=>
        @notify
          classes: 'alert-danger'
          messageTemplate: '<span>' + msg + '</span>'
          scope: scope

      closeNotice: ()->
  ]
