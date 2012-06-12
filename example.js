// stdlib
var path  = require('path');
var fs    = require('fs');


// 3rd-party
var stylus  = require('stylus');


////////////////////////////////////////////////////////////////////////////////


var filename  = path.join(__dirname, 'foobar.styl');
var source    = fs.readFileSync(filename, 'utf8');


function find_files(pathname) {
  var files = [];

  fs.readdirSync(pathname).forEach(function (file) {
    var filename  = path.join(pathname, file);
    var stats     = fs.statSync(filename);

    if (stats.isDirectory()) {
      files = files.concat(find_files(filename));
      return;
    }

    files.push(filename);
  });

  return files.sort();
}


////////////////////////////////////////////////////////////////////////////////


stylus(source)
  .define('import_tree', function (pathname) {
    var block = this.currentBlock,
        vals  = [stylus.nodes['null']];

    pathname = path.resolve(path.dirname(filename), pathname.val);

    find_files(pathname).forEach(function (file) {
      var expr = new stylus.nodes.Expression(),
          node = new stylus.nodes.String(file),
          body;

      expr.push(node);

      body = this.visitImport(new stylus.nodes.Import(expr));
      vals = vals.concat(body.nodes);
    }, this);

    this.mixin(vals, block);
    return vals;
  })
  .render(function (err, css) {
    console.log(css);
  });
