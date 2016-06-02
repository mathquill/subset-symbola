.PHONY: all
all: basic-css

.PHONY: copy-symbola
copy-symbola:
	cp font/Symbola.ttf build/Symbola.ttf

.PHONY: subset
subset: copy-symbola
	cd vendor/philip-font-optimizer && \
	./subset.pl \
		--chars='̱!()*+,-./0123456789:;<=>˂˃[]{|}~μ÷⟨⟩π–—∂∏∑−√∫≈≤≥' \
		../../build/Symbola.ttf \
		../../build/Symbola-basic.ttf

.PHONY: convert-to-woff
convert-to-woff: subset
	node_modules/.bin/ttf2woff build/Symbola.ttf build/Symbola.woff
	node_modules/.bin/ttf2woff build/Symbola-basic.ttf build/Symbola-basic.woff

.PHONY: basic-css
basic-css: convert-to-woff
	scripts/build-inline-css build/Symbola-basic.woff build/Symbola-basic.css
