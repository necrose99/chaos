# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit autotools gnome2 eutils

DESCRIPTION="New main menu for gnome"
HOMEPAGE="http://www.gnome.org"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/0.9/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="beagle"

DEPEND=""
RDEPEND="gnome-base/gnome-panel
		gnome-extra/gnome-system-monitor
		gnome-extra/yelp
		beagle? ( app-misc/beagle )
		gnome-extra/gnome-screensaver
		net-misc/networkmanager
		x11-terms/gnome-terminal
		gnome-extra/gnome-power-manager
		>=net-print/cups-1.2
		>=net-print/gnome-cups-manager-0.31-r1
		gnome-extra/nautilus-sendto
		sys-apps/hal
		dev-libs/libslab"

src_unpack(){

	gnome2_src_unpack
	
#	epatch ${FILESDIR}/control-center-apps.patch;
#	epatch ${FILESDIR}/control-center-list.patch;
#	epatch ${FILESDIR}/slab-schema.patch
#	epatch ${FILESDIR}/file-location-lookup.patch
#	epatch ${FILESDIR}/${PN}-doc_check.patch
#	epatch ${FILESDIR}/package-lookup.patch
#	epatch ${FILESDIR}/upgrade-uninstall.patch
#	cp ${FILESDIR}/gnome-main-menu-application-install.desktop.in ${S}/main-menu/etc/
#	sed -i -e 's/main-menu-rug/gnome-main-menu-application-install/g' \
#	${S}/main-menu/etc/Makefile.* || die "Error modifying Makefiles"



}

src_compile(){

#	eautoreconf
#	econf
#	./autogen.sh --prefix=/usr
	econf
	make DESTDIR=${D}
}