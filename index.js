/*!
Licensed under the MIT license.
*/

var fs, getImportNodes, getImportNodesFromDir, getImportNodesFromFile, getStylusFiles, glob, path, stylus, _;

fs = require('fs');

path = require('path');

stylus = require('stylus');

glob = require('glob');

_ = require('underscore');

getStylusFiles = function(dir, cwd) {
  return glob.sync("" + dir + "/**/*.css").map(function(item) {
    return cwd + item.replace(dir + '/', '');
  });
};

getImportNodesFromFile = function(filename) {
  var expr, importExpr, strNode;
  expr = new stylus.nodes.Expression();
  strNode = new stylus.nodes.String(filename);
  expr.push(strNode);
  importExpr = new stylus.nodes.Import(expr);
  return importExpr;
};

getImportNodesFromDir = function(dir, cwd) {
  return _(getStylusFiles(dir, cwd)).chain().map(getImportNodesFromFile.bind(this)).flatten().unshift(stylus.nodes['null']).value();
};

getImportNodes = function(filepath, cwd) {
  var method;
  method = fs.statSync(filepath).isDirectory() ? getImportNodesFromDir : getImportNodesFromFile;
  return method.call(this, filepath, cwd);
};

module.exports = function(expr, cwd) {
  var filepath, nodes;
  filepath = path.resolve(path.dirname(this.filename), expr.val);
  // console.log(filepath);
  // console.log(glob.sync("" + filepath + "../../*/*.css") )
  nodes = getImportNodes.call(this, filepath, cwd.val);
  this.mixin(nodes, this.currentBlock);
  return nodes;
};
