
describe 'ShowController', ->
  ShowController = undefined

  beforeEach(module('enapparte'))

  beforeEach inject ($rootScope, $controller)->
    scope = $rootScope.$new()
    ShowController = $controller('ShowController', { '$scope': scope })

  it 'should be defined', ->
    expect(ShowController).toBeDefined()

  # it 'gets Show', ->
  #   console.log ShowController
  #   expect(ShowController.$scope).toBeDefined()

