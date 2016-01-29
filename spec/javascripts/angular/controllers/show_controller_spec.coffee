
describe 'ShowController', ->

  beforeEach(module('enapparte'))

  it 'should be defined', inject (ShowController)->
    expect(ShowController).toBeDefined()
