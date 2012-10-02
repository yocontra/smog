## Information

<table>
<tr> 
<td>Package</td><td>smog</td>
</tr>
<tr>
<td>Description</td>
<td>HTML5/Node/WebSocket MongoDB viewer</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.6</td>
</tr>
</table>

## Usage

Install smog by running ```npm install smog -g```

### Local

smog will run on port 8080 by default (add PORT=X at the front of the command to change this)

```
$ smog
```

### Web Client

Don't want to trouble yourself with installing smog? Visit http://smog.jit.su/ to try it out

### Desktop UI

Desktop UI is still in testing but you can try it at your own risk. Linux only (for now)

```
$ smog -u
```

## Pictures

![Administration](http://i.minus.com/iD9QIHyUZGYEg.png)
![Editing](http://i.minus.com/i8JPNXYRWrxTk.png)

## TODO

##### Administration

* Ability to shutdown/restart server
* Streaming CPU/bandwidth usage graphs
* Streaming Geo heatmap graph
* Full replica set management

##### Editor

* Command bar for executing raw commands (with auto-complete/syntax highlighting)
* Support for arbitrary languages (coffee-script, clojurescript, etc.)
* Allow changing of themes/syntax highlighters
* Runtime syntax checks of all languages

##### Document Listing

* Sort by X
* Better document preview
* Streaming results (when a new document is added that matches the query it should be added)
* Inline editor
* Graphs
* Pagination

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
