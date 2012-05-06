define ["routes/connect",
 "routes/disconnect",
 "routes/home",

 "routes/new",
 "routes/collection",
 "routes/rename",
 "routes/drop",
 "routes/empty",
 "routes/insert",
 "routes/find"
 "routes/mapReduce",
 
 "routes/edit",
 "routes/delete"], 
 (connect, disconnect, home, nu, collection, rename, drop, empty, insert, find, mapReduce, edit, del) ->
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
  '/find/:name': find
  '/mapReduce/:name': mapReduce

  # document actions
  '/edit/:name/:id': edit
  '/delete/:name/:id/:nativeId': del