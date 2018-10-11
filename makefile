
SRC_CR = $(shell find ./src -name '*.cr')
SRC_CRYPTO = $(shell find ./crypto/src -name '*.c') ./crypto/makefile

.PHONY: clean test

bin/srii: $(SRC_CR) crypto/lib/libsrii-crypto.a bin
	crystal build ./src/srii.cr -o $@

crypto/lib/libsrii-crypto.a: $(SRC_CRYPTO)
	$(MAKE) -C ./crypto

bin:
	mkdir bin

clean:
	$(MAKE) -C ./crypto clean
	rm bin -rfv

test:
	$(MAKE) -C ./crypto test
	crystal spec
