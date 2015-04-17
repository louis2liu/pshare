if Meteor.isClient 

  Template.hello.events
    'click button': ->
        MeteorCamera.getPicture {},(e,r)->
          if e?
             alert(e.message)
          else
             myColl.insert {time:new Date(), pic: r}
             uploadCount = (Session.get 'mycount') or 0
             uploadCount +=1
             Session.set 'mycount', uploadCount

    'click img.small-image': (e,t)->
        uploadCount = (Session.get 'mycount') or 0
        if uploadCount > 0
          id = e.target.getAttribute 'data-id'
          myColl.remove id
          Session.set 'mycount', uploadCount - 1

        else
          alert "你不能删除多于你上传(#{uploadCount}张)的图片！"

  Template.hello.helpers
    pictures: ->
      myColl.find({},{sort:{time:-1}})
  