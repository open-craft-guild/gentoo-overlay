# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 desktop multilib-build pax-utils systemd unpacker xdg

DESCRIPTION="Fortinet VPN client"
HOMEPAGE="https://www.fortinet.com/products/endpoint-security/forticlient"

SRC_URI="https://repo.fortinet.com/repo/${PN}/$(ver_cut 1-2)/ubuntu22/pool/non-free/f/${PN}/${PN}_${PV}_amd64.deb"

LICENSE="Fortinet"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-crypt/libsecret:0[${MULTILIB_USEDEP}]
	app-arch/gzip[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/libglvnd:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux:0[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libnotify:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXcursor:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libXi:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libXrender:0[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver:0[${MULTILIB_USEDEP}]
	x11-libs/libXtst:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	appindicator? ( dev-libs/libayatana-appindicator )"

QA_PREBUILT="opt/forticlient/certd
	opt/forticlient/confighandler
	opt/forticlient/edrcomm
	opt/forticlient/epctrl
	opt/forticlient/fazlogupload
	opt/forticlient/fchelper
	opt/forticlient/fctdns
	opt/forticlient/fctsched
	opt/forticlient/firewall
	opt/forticlient/fmon
	opt/forticlient/forticlient-cli
	opt/forticlient/fortitray
	opt/forticlient/fortitraylauncher
	opt/forticlient/FortiGuardAgent
	opt/forticlient/iked
	opt/forticlient/legacy.so
	opt/forticlient/libav.so
	opt/forticlient/libvcm.so
	opt/forticlient/scanunit
	opt/forticlient/update
	opt/forticlient/vpn
	opt/forticlient/vulscan
	opt/forticlient/webfilter
	opt/forticlient/ztproxy"

QA_FLAGS_IGNORED="opt/forticlient/forticlient-cli
	opt/forticlient/libvcm.so
	opt/forticlient/ztproxy
	opt/forticlient/gui/libEGL.so
	opt/forticlient/gui/libvulkan.so
	opt/forticlient/gui/libvk_swiftshader.so
	opt/forticlient/gui/chrome-sandbox
	opt/forticlient/gui/FortiClient
	opt/forticlient/gui/libGLESv2.so
	opt/forticlient/gui/libffmpeg.so
	opt/forticlient/gui/FortiClient
	opt/forticlient/gui/libffmpeg.so"

S="${WORKDIR}"

src_install() {
	keepdir /var/lib/forticlient /etc/forticlient /opt/forticlient/{XMLs,quarantine} \
		/var/log/forticlient/{fmon,vcm}_log

	for size in 16x16 22x22 24x24 32x32 48x48 64x64 128x128 256x256 ; do
		newicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/forticlient.png \
			forticlient.png
	done

	dosym ../icons/hicolor/256x256/apps/forticlient.png \
		/usr/share/pixmaps/forticlient.png

	insinto /usr/share/polkit-1/actions
	doins usr/share/polkit-1/actions/org.fortinet.forti{client,tray}.policy

	domenu usr/share/applications/forticlient{,-register}.desktop \
		opt/forticlient/Fortitray.desktop

	exeinto /opt/forticlient
	doexe opt/forticlient/certd \
		opt/forticlient/confighandler \
		opt/forticlient/edrcomm \
		opt/forticlient/epctrl \
		opt/forticlient/fazlogupload \
		opt/forticlient/fchelper \
		opt/forticlient/fctdns \
		opt/forticlient/fctsched \
		opt/forticlient/firewall \
		opt/forticlient/fmon \
		opt/forticlient/forticlient-cli \
		opt/forticlient/FortiGuardAgent \
		opt/forticlient/fortitray \
		opt/forticlient/fortitraylauncher \
		opt/forticlient/iked \
		opt/forticlient/legacy.so \
		opt/forticlient/libav.so \
		opt/forticlient/libvcm.so \
		opt/forticlient/scanunit \
		opt/forticlient/start-fortitray-launcher.sh \
		opt/forticlient/unlock-gui.sh \
		opt/forticlient/update \
		opt/forticlient/vpn \
		opt/forticlient/vulscan \
		opt/forticlient/webfilter \
		opt/forticlient/ztproxy

	insinto /opt/forticlient
	doins opt/forticlient/.acl \
		opt/forticlient/.config.db.init \
		opt/forticlient/exe.manifest \
		opt/forticlient/icdb \
		opt/forticlient/isdb_app.txt \
		opt/forticlient/isdb_map.dat \
		opt/forticlient/libcertd.so \
		opt/forticlient/stop-forticlient.sh \
		opt/forticlient/TLS_whitelist.json \
		opt/forticlient/wf_intercepted_apps.json

	insinto /opt/forticlient/images
	doins -r opt/forticlient/images/.

	insinto /opt/forticlient/tpm2
	doins -r opt/forticlient/tpm2/.

	insinto /opt/forticlient/gui
	doins -r opt/forticlient/gui/.

	insinto /opt/forticlient/vcm_sig
	doins opt/forticlient/vcm_sig/vulns.dat

	insinto /opt/forticlient/vir_sig
	doins opt/forticlient/vir_sig/vir_high

	fperms +x /opt/forticlient/gui/chrome-sandbox \
		/opt/forticlient/gui/chrome_crashpad_handler \
		/opt/forticlient/gui/FortiClient \
		/opt/forticlient/gui/libEGL.so \
		/opt/forticlient/gui/libffmpeg.so \
		/opt/forticlient/gui/libGLESv2.so \
		/opt/forticlient/gui/libvk_swiftshader.so \
		/opt/forticlient/gui/libvulkan.so.1

	fperms +x /opt/forticlient/tpm2/bin/tpm2


	dodir /opt/bin
	dosym ../forticlient/gui/FortiClient opt/bin/FortiClient
	dosym ../../opt/forticlient/forticlient-cli  /usr/bin/forticlient

	systemd_dounit lib/systemd/system/forticlient.service

	pax-mark -m "${ED}"/opt/forticlient/gui/FortiClient
}
