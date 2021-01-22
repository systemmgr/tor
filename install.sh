#!/usr/bin/env bash

APPNAME="tor"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author          : Jason
# @Contact         : casjaysdev@casjay.net
# @File            : install.sh
# @Created         : Fr, Aug 28, 2020, 00:00 EST
# @License         : WTFPL
# @Copyright       : Copyright (c) CasjaysDev
# @Description     : installer script for tor
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

SCRIPTSFUNCTURL="${SCRIPTSAPPFUNCTURL:-https://github.com/casjay-dotfiles/scripts/raw/master/functions}"
SCRIPTSFUNCTDIR="${SCRIPTSAPPFUNCTDIR:-/usr/local/share/CasjaysDev/scripts}"
SCRIPTSFUNCTFILE="${SCRIPTSAPPFUNCTFILE:-app-installer.bash}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -f "$SCRIPTSFUNCTDIR/functions/$SCRIPTSFUNCTFILE" ]; then
  . "$SCRIPTSFUNCTDIR/functions/$SCRIPTSFUNCTFILE"
elif [ -f "$HOME/.local/share/CasjaysDev/functions/$SCRIPTSFUNCTFILE" ]; then
  . "$HOME/.local/share/CasjaysDev/functions/$SCRIPTSFUNCTFILE"
else
  curl -LSs "$SCRIPTSFUNCTURL/$SCRIPTSFUNCTFILE" -o "/tmp/$SCRIPTSFUNCTFILE" || exit 1
  . "/tmp/$SCRIPTSFUNCTFILE"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
system_installdirs

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make sure the scripts repo is installed

scripts_check

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Defaults
APPNAME="${APPNAME:-tor}"
APPDIR="/usr/local/etc/$APPNAME"
INSTDIR="${INSTDIR}"
REPO="${SYSTEMMGRREPO:-https://github.com/systemmgr}/${APPNAME}"
REPORAW="${REPORAW:-$REPO/raw}"
APPVERSION="$(__appversion $REPORAW/master/version.txt)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# dfmgr_install fontmgr_install systemmgr_install pkmgr_install systemmgr_install thememgr_install wallpapermgr_install

systemmgr_install

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Script options IE: --help

show_optvars "$@"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Requires root - no point in continuing

sudoreq # sudo required
#sudorun  # sudo optional

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end with a space

APP="$APPNAME nyx torsocks "

# install packages - useful for package that have the same name on all oses
install_packages $APP

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ensure directories exist

ensure_dirs
ensure_perms

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Main progam

if [ -d "$INSTDIR/.git" ]; then
  execute \
    "git_update $INSTDIR" \
    "Updating $APPNAME configurations"
else
  execute \
    "backupapp && \
        git_clone -q $REPO/$APPNAME $INSTDIR" \
    "Installing $APPNAME configurations"
fi

# exit on fail
failexitcode

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# run post install scripts

run_postinst() {
  systemmgr_run_postinst
  devnull systemctl stop tor tor-site.service
  mkdir -p /usr/local/share/tor/public
  cp_rf "$INSTDIR/site/public/." /usr/local/share/tor/public/
  cp_rf "$INSTDIR/site/tor-site.service" /etc/systemd/system/tor-site.service
  cp_rf "$APPDIR" /etc/tor/torrc
  cp_rf "$APPDIR" /etc/tor/torsocks
  devnull chmod go-rwx /var/lib/tor/hidden_service
  devnull chown -Rf "$(getuser tor)":"$(getuser tor)" /usr/local/share/tor
  devnull chown -Rf "$(getuser tor)":"$(getuser tor)" /etc/tor
  devnull systemctl daemon-reload
  devnull systemctl enable --now tor tor-site.service
  devnull chmod go-rwx /var/lib/tor/hidden_service
  devnull systemctl restart tor tor-site.service && sleep 30
  replace "/usr/local/share/tor/public" "MYHOSTNAME" "$(hostname -s)"
}

execute \
  "run_postinst" \
  "Running post install scripts"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# create version file

systemmgr_install_version

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# exit
run_exit

# end
