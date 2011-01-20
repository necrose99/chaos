# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Tracking software for asset recovery"
HOMEPAGE="http://preyproject.com/"
SRC_URI="http://preyproject.com/releases/0.3.73/prey-0.3.73-linux.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk"
IUSE_LINGUAS="en it sv es"
for iuse_linguas in ${IUSE_LINGUAS}; do
	IUSE="${IUSE} linguas_${iuse_linguas}"
done
IUSE_MODULES="+alarm +alert +geo +network +session webcam"
IUSE="${IUSE} ${IUSE_MODULES}"

DEPEND=""
#TODO: some of these deps may be dependent on USE
RDEPEND="${DEPEND}
	|| ( net-misc/curl net-misc/wget )
	|| ( media-gfx/imagemagick media-gfx/scrot )
	webcam? ( media-tv/xawtv )
	dev-perl/IO-Socket-SSL
	dev-perl/Net-SSLeay
	gtk? ( dev-python/pygtk )
	app-shells/bash
	virtual/cron
"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch ${FILESDIR}/${P}-functions.diff
}
src_compile() {
	:
}
src_install() {
	# Remove config app if -gtk
	use gtk || rm -f platform/linux/prey-config.py

	# clear out unneeded language files
	for lang in ${IUSE_LINGUAS}; do
		use "linguas_${lang}" || rm -f lang/${lang} modules/*/lang/${lang}
	done


	# Core files
	insinto /usr/share/prey
	doins -r core lang pixmaps platform version

	# Main script
	dobin prey.sh
	dosed 's,readonly base_path=`dirname "$0"`,readonly base_path="/usr/share/prey",' /usr/bin/prey.sh

	# Put the configuration file into /etc, strict perms, symlink
	insinto /etc/prey
	mv config prey.conf
	doins prey.conf
	fperms 700 /etc/prey
	fperms 600 /etc/prey/prey.conf
	dosym /etc/prey/prey.conf /usr/share/prey/config

	# Add cron.d script
	insinto /etc/cron.d
	doins "${FILESDIR}/prey.cron"
	fperms 600 /etc/cron.d/prey.cron

	dodoc README

	# modules
	cd modules
	for mod in *
	do
		use ${mod} || continue

		# move config, if present, to /etc/prey
		if [ -f $mod/config ]
		then
			mv "$mod/config" "mod-$mod.conf"
			insinto "/etc/prey"
			doins "mod-$mod.conf"
			fperms 600 "/etc/prey/mod-$mod.conf"
			dosym "/etc/prey/mod-$mod.conf" "/usr/share/prey/modules/$mod/config"
		fi

		# Rest of the module in its expected location
		insinto /usr/share/prey/modules
		doins -r "$mod"
	done

}
pkg_postinst () {
	einfo "To run prey, modify core and module configuration in /etc/prey,"
	einfo "then uncomment the line in /etc/cron.d/prey.cron"
}
