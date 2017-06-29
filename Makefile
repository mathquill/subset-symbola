.PHONY: all
all: basic-css

.PHONY: copy-symbola
copy-symbola:
	cp font/Symbola.ttf build/Symbola.ttf

.PHONY: subset
subset: copy-symbola
	pyftsubset build/Symbola.ttf \
		--text='̱!()*+,-./0123456789:;<=>˂˃[]{|}~μ÷⟨⟩π–—∂∏∑−√∫≈≤≥∥∦⟂' \
		--output-file=build/Symbola-basic.woff \
		--flavor=woff \
		--layout-features='*' --glyph-names --symbol-cmap --legacy-cmap \
    --notdef-glyph --notdef-outline --recommended-glyphs \
    --name-IDs='*' --name-legacy --name-languages='*'

.PHONY: convert-to-woff
convert-to-woff: subset
	node_modules/.bin/ttf2woff build/Symbola.ttf build/Symbola.woff

.PHONY: basic-css
basic-css: convert-to-woff
	scripts/build-inline-css build/Symbola-basic.woff build/Symbola-basic.css
