VERSION=0.4.10

BINDIR?=/usr/bin
MANDIR?=/usr/share/man/man1
SYSCONFDIR?=/etc

DESCRIPTION=a Linux kernel updater
HELP2MAN=help2man -n "$(DESCRIPTION)" -N --version-option -v --help-option -h

all: clean prepare man

clean:
	rm -f lux.1
	[ -f "lux" ] && [ -f "lux.orig" ] && rm -f lux && mv lux.orig lux || true

prepare:
	cp lux lux.orig
	sed -e "s/@@VERSION@@/$(VERSION)/g" -i lux

man:
	$(HELP2MAN) -o lux.1 ./lux

install: prepare man
	mkdir -p $(DESTDIR)$(BINDIR)
	install lux $(DESTDIR)$(BINDIR)/lux
	mkdir -p $(DESTDIR)$(MANDIR)
	install lux.1 $(DESTDIR)$(MANDIR)/lux.1
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	install lux.conf $(DESTDIR)$(SYSCONFDIR)/lux.conf

uninstall:
	rm $(DESTDIR)$(BINDIR)/lux
	rm $(DESTDIR)$(MANDIR)/lux.1
	rm $(DESTDIR)$(SYSCONFDIR)/lux.conf
