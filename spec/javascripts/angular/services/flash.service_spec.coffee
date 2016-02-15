describe 'Flash', ->

  beforeEach(module('enapparte'))

  it '.showNotice', inject (Flash, $rootScope)->
    expect(Flash).toBeDefined()
    expect($rootScope).toBeDefined()

    spyOn $, 'notify'
    notice = 'Notice'
    Flash.showNotice(notice)
    expect($.notify).toHaveBeenCalled()
