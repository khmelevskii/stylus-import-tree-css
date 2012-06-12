Style import\_tree Proof Of Concept
===================================

This is a dummy exampe of `import_tree` implementation. Consider you have a
directory with files you need to import, instead of writing bunch of `@import`
statements in your stylus file, you might want to simply call `import_tree()`:

``` stylus
import_tree('./foobar');

// insted of:
// @import 'foobar/a'
// @import 'foobar/b'
// @import 'foobar/c/d'
```


**NOTICE** you can't flexibly control order of inclusions in this case. The only
way you can control the order in this example is filenames, imports are done in
alphabetical order. For total controll over what is included when and where,
use [Mincer][1], which will give you awesome cow power!


[1]: https://github.com/nodeca/mincer
