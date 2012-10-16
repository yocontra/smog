define ->
  dermis.route '/'
  dermis.route '/connect', 'routes/index'
  dermis.route '/disconnect'
  dermis.route '/home'
  dermis.route '/new'

  dermis.route '/collection/:name'
  dermis.route '/rename/:name'
  dermis.route '/drop/:name'
  dermis.route '/empty/:name'
  dermis.route '/insert/:name'
  dermis.route '/find/:name'
  dermis.route '/mapReduce/:name'

  # document actions
  dermis.route '/edit/:name/:id'
  dermis.route '/delete/:name/:id/:nativeId'