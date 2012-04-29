define ["routes/connect",
 "routes/disconnect",
 "routes/home",
 "routes/collection",
 "routes/copy",
 "routes/edit",
 "routes/delete"], 
 (connect, disconnect, home, collection, copy, edit, del) ->
  '/': connect
  '/connect': connect
  '/disconnect': disconnect
  '/home': home
  '/new': home
  '/collection/:name': collection
  '/copy/:name/:id': copy
  '/edit/:name/:id': edit
  '/delete/:name/:id': del