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
docdir			?=$(datarootdir)/doc/$(NAME)-$(VERSION)
mandir			?=$(datarootdir)/man
man5dir			?=$(mandir)/man5
man8dir			?=$(mandir)/man8
localstatedir	?=$(prefix)/var
runstatedir		?=$(localstatedir)/run

all:
	@printf "lux $(VERSION), a Linux kernel updater\n\n"
	@printf "%-20s%-20s\n"	\
		"DESTDIR"		"$(DESTDIR)"		\
		"bindir"		"$(bindir)"			\
		"libdir"		"$(libdir)"			\
		"libexecdir"	"$(libexecdir)"		\
		"datarootdir"	"$(datarootdir)"	\
		"datadir"		"$(datadir)"		\
		"sysconfdir"	"$(sysconfdir)"		\
		"docdir"		"$(docdir)"			\
		"mandir"		"$(mandir)"			\
		"localstatedir"	"$(localstatedir)"	\
		"runstatedir"	"$(runstatedir)"	\
		""
	@$(MAKE) --no-print-directory $(NAME) $(MANS)

clean:
	rm -f $(NAME) $(MANS)

$(NAME):	$(NAME).in
	sed \
		-e "s|@@prefix@@|$(prefix)|g"				\
		-e "s|@@exec_prefix@@|$(exec_prefix)|g"		\
		-e "s|@@libdir@@|$(libdir)|g"				\
		-e "s|@@bindir@@|$(bindir)|g"				\
		-e "s|@@libexecdir@@|$(libexecdir)|g"		\
		-e "s|@@datarootdir@@|$(datarootdir)|g"		\
		-e "s|@@datadir@@|$(datadir)|g"				\
		-e "s|@@sysconfdir@@|$(sysconfdir)|g"		\
		-e "s|@@docdir@@|$(docdir)|g"				\
		-e "s|@@mandir@@|$(mandir)|g"				\
		-e "s|@@localstatedir@@|$(localstatedir)|g"	\
		-e "s|@@runstatedir@@|$(runstatedir)|g"		\
		-e "s|@@VERSION@@|$(VERSION)|g"				\
		$(NAME).in > $(NAME)
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
