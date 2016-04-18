angular.module('rails').factory 'saveIndicatorInterceptor', ->
  {
    'beforeRequest': (httpConfig, resourceConstructor, context) ->
      if context and (httpConfig.method == 'post' or httpConfig.method == 'put')
        context.savePending = true
      httpConfig
    'afterResponse': (result, resourceConstructor, context) ->
      if context
        context.savePending = false
      result
    'afterResponseError': (rejection, resourceConstructor, context) ->
      if context
        context.savePending = false
      $q.reject rejection

  }
