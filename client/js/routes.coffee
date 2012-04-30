define ["routes/connect",
 "routes/disconnect",
 "routes/home",

 "routes/new",
 "routes/collection",
 "routes/rename",
 "routes/drop",
 "routes/empty",
 "routes/insert"

 "routes/copy",
 "routes/edit",
 "routes/delete"], 
 (connect, disconnect, home, nu, collection, rename, drop, empty, insert, copy, edit, del) ->
  '/': connect
  '/connect': connect
  '/disconnect': disconnect
  '/home': home

  # collections
  '/new': nu
  '/collection/:name': collection
  '/rename/:name': rename
  '/drop/:name': drop
  '/empty/:name': empty
  '/insert/:name': insert

  # documents
  '/copy/:name/:id': copy
  '/edit/:name/:id': edit
  '/delete/:name/:id': del