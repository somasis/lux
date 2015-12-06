NAME	=lux
VERSION	=0.6.0

MANS	=lux.conf.5 lux.8

DESTDIR			?=$(PWD)/image
prefix			?=/usr/local
exec_prefix		?=$(prefix)
bindir			?=$(exec_prefix)/bin
sbindir			?=$(exec_prefix)/sbin
libdir			?=$(exec_prefix)/lib
libexecdir		?=$(exec_prefix)/libexec
datarootdir		?=$(prefix)/share
datadir			?=$(datarootdir)
sysconfdir		?=$(prefix)/etc
docdir			?=$(datarootdir)/doc/$(NAME)
mandir			?=$(datarootdir)/man
man1dir			?=$(mandir)/man1
man2dir			?=$(mandir)/man2
man3dir			?=$(mandir)/man3
man4dir			?=$(mandir)/man4
man5dir			?=$(mandir)/man5
man6dir			?=$(mandir)/man6
man7dir			?=$(mandir)/man7
man8dir			?=$(mandir)/man8
localstatedir	?=$(prefix)/var
runstatedir		?=$(localstatedir)/run

all:	$(NAME) $(MANS)

clean:
	rm -f $(NAME) $(MANS)

$(NAME):
	sed -e "s/@@VERSION@@/$(VERSION)/g" $(NAME).in > $(NAME)
	chmod +x $(NAME)

%.5:	%.5.ronn
	ronn --pipe --roff --organization="$(NAME) $(VERSION)" --manual="File Formats Manual" $< > $@

%.8:	%.8.ronn
	ronn --pipe --roff --organization="$(NAME) $(VERSION)" --manual="System Manager's Manual" $< > $@

install:	doc $(NAME) $(MANS)
	mkdir -p $(DESTDIR)$(bindir)
	mkdir -p $(DESTDIR)$(docdir)
	mkdir -p $(DESTDIR)$(man5dir)
	mkdir -p $(DESTDIR)$(man8dir)
	mkdir -p $(DESTDIR)$(sysconfdir)
	install -m755 $(NAME) $(DESTDIR)$(bindir)/$(NAME)
	install -m644 lux.conf.5 $(DESTDIR)$(man5dir)/lux.conf.5
	install -m644 lux.8 $(DESTDIR)$(man8dir)/lux.8
	install -m644 lux.conf $(DESTDIR)$(sysconfdir)/lux.conf
	install -m644 doc/* $(DESTDIR)$(docdir)

.PHONY:	all clean install
