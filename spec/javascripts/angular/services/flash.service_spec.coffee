describe 'Flash', ->

  beforeEach(module('enapparte'))

  it '.showNotice', inject (Flash, $rootScope)->
    expect(Flash).toBeDefined()
    expect($rootScope).toBeDefined()

    notice = 'Notice'
    Flash.showNotice(notice)
    expect($rootScope.flash.notice).toEqual(notice)
