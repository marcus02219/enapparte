angular
  .module 'enapparte'
  .service 'Flash', ['$rootScope',
    class Flash
      constructor: (@$rootScope)->

      showNotice: (msg)->
        $.notify
          message: msg

      closeNotice: ()->
  ]
