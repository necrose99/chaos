# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND=2
ESVN_REPO_URI="http://pympler.googlecode.com/svn/trunk/"
inherit distutils subversion

DESCRIPTION="Pympler is a development tool to measure, monitor and analyze the
memory behavior of Python objects in a running Python application."
HOMEPAGE="http://code.google.com/p/pympler/"
#SRC_URI="http://pypi.python.org/packages/source/P/${MY_P}/${MY_P}-${PV}.tar.gz"
#S="${WORKDIR}/${MY_P}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND=">=dev-lang/python-2.4"

