angular
  .module 'enapparte'
  .directive 'imageCrop', ()->
    {
      strict: 'A'
      link: (scope, element, attrs)->
        element.on 'load', (e)->
          width = parseInt(attrs.width)
          height = parseInt(attrs.height)
          canvas = $('<canvas/>')
            .attr
               width: width
               height: height
            .hide()
            .appendTo('body')
          ctx = canvas.get(0).getContext('2d')
          imgWidth = element[0].naturalWidth
          imgHeight = element[0].naturalHeight
          if imgWidth > imgHeight
            x = (imgWidth - imgHeight) / 2
            ctx.drawImage(element[0], x, 0, imgHeight, imgHeight, 0, 0, width, height)
          else
            y = (imgHeight - imgWidth) / 2
            ctx.drawImage(element[0], 0, y, imgHeight, imgHeight, 0, 0, width, height)
          dataUrl = canvas.get(0).toDataURL()
          element.off 'load'
          element.prop('src', dataUrl)
    }
