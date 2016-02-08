describe 'DashboardController', ->
  DashboardController = undefined

  beforeEach(module('enapparte'))

  beforeEach inject ($rootScope, $controller)->
    scope = $rootScope.$new()
    DashboardController = $controller('DashboardController', { '$scope': scope })

  it 'should be defined', ->
    expect(DashboardController).toBeDefined()

