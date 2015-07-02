# Examples of kernel_* functions

## Post install
On my machine, I use gummiboot for managing the boot process.
So, my kernel_post_install() is...

    kernel_post_install() {
        default_kernel_post_install "$@"
        sed -e "s#^linux /vmlinuz-.*#linux /vmlinuz-${target_version//v}#" -i /boot/loader/entries/exherbo.conf
    }

Which changes the kernel line in the gummiboot configuration to use the
new kernel version, so I don't have to do it by hand.
