angular
  .module 'enapparte'
  .service 'Flash', ['$rootScope', 'notify',
    class Flash
      constructor: (@$rootScope, @notify)->

      showNotice: (scope, msg)->
        @notify
          messageTemplate: '<span>' + msg + '</span>'
          scope: scope

      closeNotice: ()->
  ]
