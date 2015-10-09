VERSION=0.5

BINDIR?=/usr/bin
MANDIR?=/usr/share/man
SYSCONFDIR?=/etc

DESCRIPTION=a Linux kernel updater

all: clean prepare man

clean:
	rm -f lux.1
	[ -f "lux" ] && [ -f "lux.orig" ] && rm -f lux && mv lux.orig lux || true

prepare:
	cp lux lux.orig
	sed -e "s/@@VERSION@@/$(VERSION)/g" -i lux

man:
	ronn --roff --organization="lux $(VERSION)" --manual="System Manager's Manual" lux.1.ronn
	ronn --roff --organization="lux $(VERSION)" --manual="File Formats Manual" lux.conf.5.ronn

install: prepare man
	mkdir -p $(DESTDIR)$(BINDIR)
	install lux $(DESTDIR)$(BINDIR)/lux
	mkdir -p $(DESTDIR)$(MANDIR)/man1
	install lux.1 $(DESTDIR)$(MANDIR)/man1/lux.1
	mkdir -p $(DESTDIR)$(MANDIR)/man5
	install lux.5 $(DESTDIR)$(MANDIR)/man5/lux.conf.5
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	install lux.conf $(DESTDIR)$(SYSCONFDIR)/lux.conf

uninstall:
	rm $(DESTDIR)$(BINDIR)/lux
	rm $(DESTDIR)$(MANDIR)/man1/lux.1
	rm $(DESTDIR)$(MANDIR)/man5/lux.conf.5
	rm $(DESTDIR)$(SYSCONFDIR)/lux.conf
