PREFIX?=/usr


DESCRIPTION=a Linux kernel updater
HELP2MAN=help2man -n "$(DESCRIPTION)" -N --version-option -v --help-option -h

all: clean man

clean:
	rm -f lux.1

man:
	$(HELP2MAN) -o lux.1 ./lux

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install lux $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1
	install lux.1 $(DESTDIR)$(PREFIX)/share/man/man1
	mkdir -p $(DESTDIR)/etc
	install lux.conf $(DESTDIR)/etc/

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/lux
	rm $(DESTDIR)$(PREFIX)/share/man/man1/lux.1
	rm $(DESTDIR)/etc/lux.conf
