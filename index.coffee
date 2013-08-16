###!
Licensed under the MIT license.
###

path = require 'path'
stylus = require 'stylus'
glob = require 'glob'
_ = require 'underscore'

getStylusFiles = (path) ->
  glob.sync path + '/**/*.styl'

createImportNode = (filename) ->
  expr = new stylus.nodes.Expression()
  strNode = new stylus.nodes.String filename
  expr.push strNode
  new stylus.nodes.Import expr

module.exports = (expr) ->
  pathname = path.resolve path.dirname(@filename), expr.val

  nodes = _(getStylusFiles(pathname))
  .chain()
  .map (filename) =>
    importExpr = createImportNode filename
    @visitImport(importExpr).nodes
  .flatten()
  .unshift(stylus.nodes['null'])
  .value()

  @mixin nodes, @currentBlock
  nodes
