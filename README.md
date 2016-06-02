# subset-symbola
Generate a subset of the [Symbola](http://users.teilar.gr/~g1951d/) font suitable for mathquill-basic.

## Build Instructions

Just run `make`.

The subset of characters that make it into Symbola-basic are specified in the Makefile.

This produces the following output in the build folder:

```
build/Symbola.ttf
build/Symbola.woff
build/Symbola-basic.ttf
build/Symbola-basic.woff
build/Symbola-basic.css
```

`build/Symbola-basic.css` inlines Symbola-basic.woff as a data uri.

## TODO
For some reason, vulgar fractions like 1/2 and 1/3 are also ending up in Symbola-basic, even though we aren't asking for them.
