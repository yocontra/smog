define ["routes/connect",
 "routes/disconnect",
 "routes/home",

 "routes/new",
 "routes/collection",
 "routes/rename",
 "routes/drop",
 "routes/empty",
 "routes/insert"

 "routes/edit",
 "routes/delete"], 
 (connect, disconnect, home, nu, collection, rename, drop, empty, insert, edit, del) ->
  '/': connect
  '/connect': connect
  '/disconnect': disconnect
  '/home': home

  # collection actions
  '/new': nu
  '/collection/:name': collection
  '/rename/:name': rename
  '/drop/:name': drop
  '/empty/:name': empty
  '/insert/:name': insert

  # document actions
  '/edit/:name/:id': edit
  '/delete/:name/:id/:nativeId': del