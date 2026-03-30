#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos

# Use lightdm instead of gdm
systemctl disable gdm.service

dnf5 install -y lightdm lightdm-gtk slick-greeter

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging


systemctl enable lightdm.service

#### Example for enabling a System Unit File
systemctl enable podman.socket


## Configure lightdm guest session (source https://aur.archlinux.org/packages/lightdm-guest-account)
install -m 755 /ctx/lightdm/guest-account.sh /usr/bin/guest-account
install -m 644 /ctx/lightdm/lightdm-autologin.sysusers /usr/lib/sysusers.d/lightdm-autologin.conf
# todo: should this be in /etc as it is mutable?
install -dm 755 /etc/guest-session/skel
