# Build very rudimentary single-segment MPW Tools

all: $(patsubst %.a,%,$(wildcard *.a))
	@ls | grep ^Test | grep -v -F . | xargs -n1 mps -c | ./tapcat | ./tapview

clean:
	rm -f $(patsubst %.a,%,$(wildcard *.a))
	rm -f $(patsubst %.a,%.idump,$(wildcard *.a))
	rm -f $(patsubst %.a,%.rdump,$(wildcard *.a))

%: %.o
	@rm -rf $@ $@.rdump $@.idump
	@touch $@ $@.rdump $@.idump
	@printf 'MPSTMPS ' >$@.idump
	@echo 00000028 00008000 00000008 00000020 0000 3F3C 0001 A9F0 | xxd -r -p | rfx cp /dev/stdin $@//CODE/0
	@(echo 0000 0001 | xxd -r -p; cat $<) | rfx cp /dev/stdin $@//CODE/1

%.o: %.a
	vasmm68k_mot -quiet -w -Fbin -o $@ $<
