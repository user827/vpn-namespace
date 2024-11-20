# automake has a bug where it calls cd ${top_src_dir} && ${MAKE} am--refresh
# multiple times at the same time
# # atleast when using the always-build flag
.NOTPARALLEL:

SED_DEPENDS = $(srcdir)/Makefile

prog = ${PACKAGE_NAME}

binmode = 0755
nonbinmode = 0644
confmode = 0644


cachedir = ${localstatedir}/cache
pkgcachedir = ${cachedir}/${prog}
pkgsysconfdir = ${sysconfdir}/${prog}

#TODO actually use these
openvpnuser = openvpn
openvpngroup = network
#TODO or use uid?
openvpniface = tun_vpn
netnsentercmd = /usr/bin/ip netns exec $(vpnnetns)

hostname = ${my_HOSTNAME}
domainname = ${my_DOMAINNAME}

defaultnetns = default
vpnnetns = vpn

EXTRA_DIST =
in_files = $(filter %.in,$(EXTRA_DIST))
CLEANFILES = $(in_files:.in=)

bash_scripts =

inscripts = scripts/updown.sh.in \
	    scripts/functions.sh.in \
	    scripts/openvpn.in \
	    scripts/filesystem-checks.sh.in
scriptdir = $(pkglibdir)
script_SCRIPTS = $(inscripts:.in=)
dist_script_SCRIPTS = scripts/unpriv-ip scripts/dummy-ip
EXTRA_DIST += $(inscripts)
bash_scripts += ${script_SCRIPTS} ${dist_script_SCRIPTS}

hooks = route_up_hooks/50ready.sh.in \
	up_hooks/10dns.sh.in
hookexecdir = $(pkglibdir)
nobase_hookexec_SCRIPTS = $(hooks:.in=)
EXTRA_DIST += $(hooks)
bash_scripts += ${nobase_hookexec_SCRIPTS}


openvpnconfdir = $(sysconfdir)/openvpn
openvpnconf_DATA = configs/openvpn/vpnns.conf
EXTRA_DIST += configs/openvpn/vpnns.conf.in

sudoersdir = $(sysconfdir)/sudoers.d
sudoers_DATA = configs/sudoers.d/vpnns
EXTRA_DIST += configs/sudoers.d/vpnns.in

nftablesconfdir = $(sysconfdir)/nftables.defaultns.d
dist_nftablesconf_DATA = configs/nftables/vpn-users.conf

tmpfilesdir = $(libdir)/tmpfiles.d
tmpfiles_DATA = configs/tmpfiles.d/vpnns.conf
EXTRA_DIST += configs/tmpfiles.d/vpnns.conf.in

ipnetnsdir = $(sysconfdir)/netns/$(vpnnetns)
ipnetns_DATA = configs/netns/hosts \
	       configs/netns/resolv.conf \
	       configs/netns/nsswitch.conf
EXTRA_DIST += netns/hosts.in

insystemd = systemd/openvpn-vpnns.service.in \
	    systemd/vpnns-namespace.service \
	    systemd/openvpn-tuntap.service.in
systemddir = $(libdir)/systemd/system
systemd_DATA = $(insystemd:.in=)
EXTRA_DIST += $(insystemd)

# promised to be executed after the file is installed
install-data-hook:
	chmod -R o= ${DESTDIR}${openvpnconfdir}/vpnns.conf
	chmod -R o= ${DESTDIR}${sudoersdir}
	chown openvpn:openvpn ${DESTDIR}${sysconfdir}/netns/$(vpnnetns)/resolv.conf
	chown openvpn:openvpn ${DESTDIR}${sysconfdir}/netns/$(vpnnetns)/hosts

check_bash_scripts = $(addprefix check_,$(bash_scripts))
.PHONY: ${check_bash_scripts}
${check_bash_scripts}: all
	bash -n $(patsubst check_%,%,$@)

check-local: ${check_bash_scripts}
	${CHECK_OUTPUTVARS_PROCESS} $(in_files:.in=)

SED_PROCESS = \
              $(AM_V_GEN)$(INSTALL) -d $(dir $@) && \
              $(SED) $(subst '|,-e 's|@,$(subst =,\@|,$(subst |',|g',$(substitutions)))) \
              < $< > $@

CHECK_OUTPUTVARS_PROCESS = ! grep '@[^ ]*@'


substitutions = \
		'|BINDIR=$(bindir)|' \
		'|CACHEDIR=$(cachedir)|' \
		'|DOMAINNAME=$(domainname)|' \
		'|HOSTNAME=$(hostname)|' \
		'|LIBDIR=$(libdir)|' \
		'|LOCALSTATEDIR=$(localstatedir)|' \
		'|PKGCACHEDIR=$(pkgcachedir)|' \
		'|PKGLIBDIR=$(pkglibdir)|' \
		'|PKGRUNDIR=/run/$(prog)|' \
		'|PKGSYSCONFDIR=$(pkgsysconfdir)|' \
		'|PROG=$(prog)|' \
		'|RUNDIR=/run|' \
		'|SYSCONFDIR=$(sysconfdir)|' \
		'|VERSION=$(VERSION)|' \
		'|hookdir=$(hookexecdir)|' \
		'|hooklibdir=$(pkglibdir)/hooks/lib|' \
		'|netnsentercmd=$(netnsentercmd)|' \
		'|openvpniface=$(openvpniface)|' \
		'|openvpnuser=$(openvpnuser)|' \
		'|openvpngroup=$(openvpngroup)|' \
		'|openvpnrundir=/run/openvpn|' \
		'|vpnnetns=$(vpnnetns)|'


%: %.in ${SED_DEPENDS}
	${SED_PROCESS}
