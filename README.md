# lux, a linux kernel updater

An [ISC-licensed](LICENSE) kernel tree updater which takes care of getting a kernel tree,
fetching incremental updates to it, configuration, and installation, in a
simple process which takes out the grunt work from updating.

## Requirements
- [git](http://git-scm.com)
- [help2man](https://www.gnu.org/software/help2man)
- [Everything compiling a kernel entails](https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/Documentation/Changes)

## Installation
**Exherbo users, there is an exheres in ::somasis; sys-kernel/lux.**

1. `git clone https://github.com/Somasis/lux` or [download a release] [1].
2. `make PREFIX=/usr/local`
3. `make install`

## Usage
After installation, just run `man lux`. If you prefer, you can also just do `lux -h`.

## Rationale
On Linux distributions, you often have to choose between a few options for
keeping the kernel updated to the latest version:
- binary packages which just have everything you could possibly need in it
- source based distributions which provide a huge config for everything
- manually updating the kernel, which means manually checking for updates
- ?

Being a user of [Exherbo Linux](http://www.exherbo.org), which is source-based,
I must maintain my own kernel, because they do not provide a kernel package:

1. Check kernel.org
2. Decide if I want to use -stable, -longterm, or whatever
3. Download the latest version in tarball format if I'm lazy, or update it with
patches if I hate myself and love to suffer
4. `make silentoldconfig`
5. Install it, reboot

I got to thinking. Why not just automate all this? And so, I looked for ways to
do this. A tool called [ketchup](https://github.com/psomas/ketchup) does what
I want, but it looks unmaintained now, and the latest revision is 3 years old.
It's rather broken, and doesn't actually seem to know there's any kernel version
above version 3.3.

So, I've taken it upon myself to make this, which will automate the procedure.

## How does it work?
As you probably know, the kernel developers are very smart people, and this guy
called Linus Torvalds made a wonderful version control system named `git`.
A lot of people use it. It works very well, and the kernel developers use it for
holding the branches and trees of kernel development.

In addition to that, they publish releases of the kernel using a git construct
called `tags`. Tags mark releases, and releases of the kernel are tagged with
their version number.

Since we have advanced towards not using tarballs for darn-near everything, and
have left the dark ages, why not take advantage of git's very smart methods of
data transfer and versioning, and apply them to how we update the kernel?

As such, `lux` uses git commands to keep the kernel tree up-to-date. It works
using the kernel remote repositories (by default, https://git.kernel.org/) and
checking what you have in your kernel tree against that, and then resetting any
modifications on your end, and pulling in new changes from the kernel tree.

## Who is this meant for?
Users of the Linux kernel who have to compile it. `lux` is **not** for kernel
developers, or people who often modify kernel code for their system. It is only
for users that compile it, and configure it.

`lux` **resets** every last change you make to the kernel's source tree, and if you
are a developer, you'll probably be really angry about that.

**Do not use `lux` if you are not prepared for it to reset the tree contents.**

(kernel configurations, however, are backed up and used for upgrading)

[1]: https://github.com/Somasis/lux/releases
