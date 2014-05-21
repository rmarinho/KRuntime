#!/bin/bash

# $userKrePath = $env:USERPROFILE + "\.kre"
# $userKrePackages = $userKrePath + "\packages"
# $globalKrePath = $env:ProgramFiles + "\KRE"
# $globalKrePackages = $globalKrePath + "\packages"
BUILD_NUMBER=1;

function Kvm-Global-Setup() {
	echo"setup";
}

function Kvm-Help() {
echo "K Runtime Environment Version Manager - Build $BUILD_NUMBER

USAGE: kvm <command> [options]

kvm upgrade [-x86][-x64] [-svr50][-svrc50] [-g|-global]
  install latest KRE from feed
  set 'default' alias to installed version
  add KRE bin to user PATH environment variable persistently
  -g|-global        install to machine-wide location

kvm install <semver>|<alias>|<nupkg> [-x86][-x64] [-svr50][-svrc50] [-g|-global]
  install requested KRE from feed
  add KRE bin to path of current command line
  -g|-global        install to machine-wide location

kvm use <semver>|<alias>|none [-x86][-x64] [-svr50][-svrc50] [-p|-persistent] [-g|-global]
  <semver>|<alias>  add KRE bin to path of current command line   
  none              remove KRE bin from path of current command line
  -p|-persistent    add KRE bin to PATH environment variables persistently
  -g|-global        combined with -p to change machine PATH instead of user PATH

kvm list
  list KRE versions installed 

kvm alias
  list KRE aliases which have been defined

kvm alias <alias>
  display value of named alias

kvm alias <alias> <semver> [-x86][-x64] [-svr50][-svrc50]
  set alias to specific version

";};

OPTIND=1 
# Initialize our own variables:
output_file=""
verbose=0

while getopts "h?vf:" opt; do
    case "$opt" in
    h|\?)
        Kvm-Help
        exit 0
        ;;
    v)  verbose=1
        ;;
    setup)  Kvm-Global-Setup
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

echo "verbose=$verbose, output_file='$output_file', Leftovers: $@"
