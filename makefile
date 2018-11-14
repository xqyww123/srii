
SRC_CR = $(shell find ./src -name '*.cr')
SRC_CRYPTO = $(shell find ./crypto/src -name '*.c') ./crypto/makefile

export LIBRARY_PATH := $(shell pwd)/crypto/lib/:$(LIBRARY_PATH)

.PHONY: clean test crypto

crypto: crypto/lib/libsrii-crypto.a crypto/lib/libsrii-relic.a

bin/srii: $(SRC_CR) crypto bin
	crystal build ./src/srii.cr -o $@

crypto/lib/libsrii-crypto.a: $(SRC_CRYPTO)
	$(MAKE) -C ./crypto

bin:
	mkdir bin

clean:
	$(MAKE) -C ./crypto clean
	rm bin -rfv

test: crypto
	#$(MAKE) -C ./crypto test
	crystal spec
