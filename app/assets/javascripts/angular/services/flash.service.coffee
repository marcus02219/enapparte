angular
  .module 'enapparte'
  .service 'Flash', ['$rootScope',
    class Flash
      constructor: (@$rootScope)->
        @$rootScope.flash = null

      showNotice: (msg)->
        @$rootScope.flash = {}  unless @$rootScope.flash
        @$rootScope.flash.notice = msg

      closeNotice: ()->
        @$rootScope.flash.notice = undefined
  ]
