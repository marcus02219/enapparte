angular
  .module 'enapparte'
  .service 'Flash', ['$rootScope',
    class Flash
      constructor: (@$rootScope)->
        @$rootScope.flash = null

      showNotice: (msg)->
        @$rootScope.flash = {}  unless @$rootScope.flash
        @$rootScope.flash.notice = msg
  ]
