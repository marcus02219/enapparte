angular
  .module 'enapparte'
  .directive 'tabs', ()->
    {
      strict: 'E'
      templateUrl: 'directives/tabs.html'
      replace: true
      transclude: true
      controller: 'TabsController'
    }
  .directive 'tabsVertical', ()->
    {
      require: '^tabs'
      strict: 'E'
      templateUrl: 'directives/tabs_vertical.html'
      replace: true
    }
  .directive 'tabPanes', ()->
    {
      strict: 'E'
      templateUrl: 'directives/tab_panes.html'
      transclude: true
      replace: true
    }
  .directive 'tabPane', ()->
    {
      require: '^tabs'
      strict: 'E'
      scope:
        title: '@'
      templateUrl: 'directives/tab_pane.html'
      transclude: true
      replace: true
      link: (scope, element, attrs, tabsController)->
        tabsController.addPane scope
    }
