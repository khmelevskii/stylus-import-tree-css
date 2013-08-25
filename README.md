# stylus-import-tree

This plugin allows you to recursively import entire directories instead of writing bunch of `@import`
statements in your stylus file:

```stylus
import_tree('./foobar')

// insted of:
// @import 'foobar/a'
// @import 'foobar/b'
// @import 'foobar/c/d'
```

## Import order
Files will be imported in alphabetical order based on filename. To import the files in a specific order you can either name them accordingly, use this plugin in conjunction with a build tool such as [Grunt](http://gruntjs.com/), or import them separately:

```stylus
@import 'variables'
@import 'base'

import_tree('./modules')
```

## Setup
You can setup this plugin using [define](https://github.com/LearnBoost/stylus/blob/master/docs/js.md#definename-fn)

### Standalone
```coffeescript
importTree = require 'stylus-import-tree'

stylus(str)
.define("import_tree", importTree)
.render (err, css) ->
  throw err if err
  console.log css
```

### Grunt
```coffeescript
grunt.initConfig
  stylus:
    dist:
      options:
        define:
          import_tree: require 'stylus-import-tree'
      files:
        'tmp/assets/styles/app.css': ['app/styles/app.styl']
```

## Credit
This is a fork of [Style import_tree Proof of Concept](https://github.com/ixti/stylus-import-tree) by Aleksey V. Zapparov.

## License
[MIT](https://github.com/tuxracer/stylus-import-tree/blob/master/LICENSE)
