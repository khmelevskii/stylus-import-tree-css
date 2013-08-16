###!
Licensed under the MIT license.
###

fs = require 'fs'
path = require 'path'
stylus = require 'stylus'
glob = require 'glob'
_ = require 'underscore'

getStylusFiles = (dir) ->
  glob.sync "#{dir}/**/*.styl"

getImportNodesFromFile = (filename) ->
  expr = new stylus.nodes.Expression()
  strNode = new stylus.nodes.String filename
  expr.push strNode
  importExpr = new stylus.nodes.Import expr
  @visitImport(importExpr).nodes

getImportNodesFromDir = (dir) ->
  _(getStylusFiles dir)
  .chain()
  .map(getImportNodesFromFile.bind @)
  .flatten()
  .unshift(stylus.nodes['null'])
  .value()

getImportNodes = (path) ->
  method = if fs.statSync(path).isDirectory() then getImportNodesFromDir else getImportNodesFromFile
  method.call @, path

module.exports = (expr) ->
  path = path.resolve path.dirname(@filename), expr.val
  nodes = getImportNodes.call @, path

  @mixin nodes, @currentBlock
  nodes
