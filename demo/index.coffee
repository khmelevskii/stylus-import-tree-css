###!
Licensed under the MIT license.
###

importTree = require('../index')
fs = require 'fs'
path = require 'path'
stylus = require 'stylus'

filename = path.join __dirname, "stylus-sources/foobar.styl"
source = fs.readFileSync filename, "utf8"

stylus(source, filename: filename)
.define("import_tree", importTree)
.render (err, css) ->
  console.log css
