ifeq ($(RELIC),)
RELIC := ./relic_src
endif

RELIC_GIT := https://github.com/relic-toolkit/relic.git
C_FLAG := -I$(RELIC)/include/ -Irelic/include

define print
echo -e "\033[1;35m$(1)\033[0m"
endef

.PHONY: all relic clean test

all: lib/libsrii-crypto.o lib/libsrii-crypto.so lib/libsrii-crypto.a lib/libsrii-relic.a lib/libsrii-relic.so

define relic
	if [ ! -d $(RELIC) ]; then git clone $(RELIC_GIT) $(RELIC); fi
	mkdir -p relic
	cd relic && \
	cmake -DDEBUG=on -DCHECK=off -DARITH=gmp -DFP_PRIME=381 -DFP_QNRES=on -DFP_METHD="BASIC;COMBA;COMBA;MONTY;LOWER;SLIDE" -DFPX_METHD="INTEG;INTEG;LAZYR" -DPP_METHD="LAZYR;OATEP" -DCOMP="-O2 -funroll-loops -fomit-frame-pointer" -DALLOC="DYNAMIC" ../$(RELIC) && \
	$(MAKE)

lib:
	mkdir lib
endef

relic/lib/librelic_s.a:
	$(call relic)

lib/libsrii-relic.a: relic/lib/librelic_s.a
	cp $< $@

relic/lib/librelic.so:
	$(call relic)

lib/libsrii-relic.so: relic/lib/librelic.so
	cp $< $@

lib/libsrii-crypto.o: src/crypto.c lib
	$(CC) -c $(C_FLAG) -o $@ $<

lib/libsrii-crypto.a: lib/libsrii-crypto.o lib
	ar rcs $@ $<


lib/libsrii-crypto.so: src/crypto.c lib
	$(CC) -shared $(C_FLAG) -o $@ -fPIC $< -Lrelic/lib -lrelic

clean:
	rm ./lib ./relic -rfv

test:
	#$(call print,test relic)
	cd relic && \
	$(MAKE) test

