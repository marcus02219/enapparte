angular
  .module 'enapparte'
  .service 'Flash', ['notify',
    class Flash
      constructor: (@notify)->

      showNotice: (scope, msg)->
        @notify
          messageTemplate: '<span>' + msg + '</span>'
          scope: scope

      closeNotice: ()->
  ]
