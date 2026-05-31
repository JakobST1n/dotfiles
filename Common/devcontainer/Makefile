BASEIMAGE := devcontainer-base
M4_SRCS := $(wildcard *.m4)
TARGETS := $(patsubst %.m4,%,$(M4_SRCS))

.PHONE: all clean

all: $(TARGETS)

Dockerfile-base: Dockerfile-base.m4
	m4 -P -D BASEIMAGE="$(BASEIMAGE)" $< > $@
	podman build -t "$(patsubst Dockerfile-%,devcontainer-%,$@)" -f $@

%: %.m4
	m4 -P -D BASEIMAGE="$(BASEIMAGE)" $< > $@
	podman build -t "$(patsubst Dockerfile-%,devcontainer-%,$@)" -f $@

clean:
	rm -f $(TARGETS)
