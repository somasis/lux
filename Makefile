VERSION=0.5.1

BINDIR?=/usr/bin
MANDIR?=/usr/share/man
SYSCONFDIR?=/etc

all: clean prepare man

clean:
	rm -f lux.8 lux.conf.5
	[ -f "lux" ] && [ -f "lux.orig" ] && rm -f lux && mv lux.orig lux || true

prepare:
	cp lux lux.orig
	sed -e "s/@@VERSION@@/$(VERSION)/g" -i lux

man:
	ronn --pipe --roff --organization="lux $(VERSION)" --manual="System Manager's Manual" lux.8.ronn > lux.8
	ronn --pipe --roff --organization="lux $(VERSION)" --manual="File Formats Manual" lux.conf.5.ronn > lux.conf.5

install: prepare man
	mkdir -p $(DESTDIR)$(BINDIR)
	install lux $(DESTDIR)$(BINDIR)/lux
	mkdir -p $(DESTDIR)$(MANDIR)/man8
	install lux.8 $(DESTDIR)$(MANDIR)/man8/lux.8
	mkdir -p $(DESTDIR)$(MANDIR)/man5
	install lux.conf.5 $(DESTDIR)$(MANDIR)/man5/lux.conf.5
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	install lux.conf $(DESTDIR)$(SYSCONFDIR)/lux.conf

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/lux
	rm -f $(DESTDIR)$(MANDIR)/man8/lux.8
	rm -f $(DESTDIR)$(MANDIR)/man5/lux.conf.5
	rm -f $(DESTDIR)$(SYSCONFDIR)/lux.conf
