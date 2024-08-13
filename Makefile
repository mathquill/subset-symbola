.PHONY: all
all: basic-css convert-to-woff convert-to-woff2

.PHONY: clean
clean:
	rm build/*

.PHONY: copy-symbola
copy-symbola:
	cp font/Symbola.ttf build/Symbola.ttf

# Note: when making changes here, it can be useful to add the
# --verbose option, which explains exactly which glyphs are making it
# into the subset, and why
SUBSET_OPTIONS=\
	--text=' !()*+,-./0123456789:;<=>˂˃[]{|}~μ÷⟨⟩π–—∂∏∑−√∫≈≤≥∥∦⟂' \
	--unicodes='331' \
	--layout-features='*' --glyph-names --symbol-cmap --legacy-cmap \
	--notdef-glyph --notdef-outline --recommended-glyphs \
  --name-IDs='*' --name-legacy --name-languages='*'

# Note: EOT is not supported by pyftsubset, so we are creating the .eot version by converting the 
# .ttf subset
.PHONY: subset
subset: copy-symbola
	pyftsubset build/Symbola.ttf --output-file=build/Symbola-basic.ttf $(SUBSET_OPTIONS)
	pyftsubset build/Symbola.ttf --flavor=woff --output-file=build/Symbola-basic.woff $(SUBSET_OPTIONS)
	pyftsubset build/Symbola.ttf --flavor=woff2 --output-file=build/Symbola-basic.woff2 $(SUBSET_OPTIONS)
	npx ttf2eot build/Symbola-basic.ttf build/Symbola-basic.eot

.PHONY: convert-to-woff
convert-to-woff: subset
	node_modules/.bin/ttf2woff build/Symbola.ttf build/Symbola.woff

.PHONY: convert-to-woff2
convert-to-woff2: subset
	cat build/Symbola.ttf | npx ttf2woff2 > build/Symbola.woff2

.PHONY: basic-css
basic-css: subset
	scripts/build-inline-css build/Symbola-basic.woff2 build/Symbola-basic.css
