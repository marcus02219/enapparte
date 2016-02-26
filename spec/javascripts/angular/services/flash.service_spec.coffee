describe 'Flash', ->

  beforeEach(module('enapparte'))

  it '.showNotice', inject (Flash, $rootScope, notify)->
    expect(Flash).toBeDefined()
    scope = $rootScope.$new(09poo)

    #FIXME
    # spyOn notify
    # notice = 'Notice'
    # Flash.showNotice(scope, notice)
    # expect(notify).toHaveBeenCalled()
