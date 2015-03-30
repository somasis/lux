BINPREFIX?=/usr/bin
MANPREFIX?=/usr/share/man/man1
ETCPREFIX?=/etc

DESCRIPTION=a Linux kernel updater
HELP2MAN=help2man -n "$(DESCRIPTION)" -N --version-option -v --help-option -h

all: clean man

clean:
	rm -f lux.1

man:
	$(HELP2MAN) -o lux.1 ./lux

install:
	mkdir -p $(DESTDIR)$(BINPREFIX)
	install lux $(DESTDIR)$(BINPREFIX)/lux
	mkdir -p $(DESTDIR)$(MANPREFIX)
	install lux.1 $(DESTDIR)$(MANPREFIX)/lux.1
	mkdir -p $(DESTDIR)$(ETCPREFIX)
	install lux.conf $(DESTDIR)$(ETCPREFIX)/lux.conf

uninstall:
	rm $(DESTDIR)$(BINPREFIX)/lux
	rm $(DESTDIR)$(MANPREFIX)/lux.1
	rm $(DESTDIR)$(ETCPREFIX)/lux.conf
