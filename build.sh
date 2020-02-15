#!/bin/sh

set -e

export PATH=$PATH:${PWD}/buildroot/output/host/bin

CLEAN=""

print_red_msg ()
{
    echo -e "\033[0;31m"$1"\033[0m"
}

print_green_msg ()
{
    echo -e "\033[1;32m""$1""\033[0m"
}

print_blue_msg ()
{
    echo -e "\033[0;34m""$1""\033[0m"
}

usage () {
    echo "$1 [options] [project name]"
    echo -e "\t-C --cleanall     clean all project building directories"
    echo -e "\t-c --clean        clean only kernel, busybox and u-boot building directories"
    echo -e "\t-h --help         print usage and exit"

}

# parse command line into arguments
res=`getopt Cch $*`
rc=$?
# check result of parsing
if [ $rc != 0 ]
then
    usage $0
    exit 1
fi

set -- $res

# set options
while [ $1 != -- ]
do
    case $1 in
    -C|--cleanall)
	CLEAN=all;;
    -c|--clean)
	CLEAN=yes;;
    -h|--help)
	usage $0
	exit 0;;
    esac
    shift   # next flag
done
shift

if [ -z "$1" ]; then
    if [ ! -d projects/$1 ]; then
	print_red_message "Project folder $1 does not exist !"
	exit 2
    fi
else
    rm -fr project
    ln -s projects/$1 project
fi

if [ ! -d project ]; then
    print_red_msg "Error: link to the project directory does not exist !!!"
    print_red_msg "Please create it manually. Example:"
    print_green_msg "ln -s projects/itan2-mmc project"
    print_red_msg "Also you can specify project name in $0 command line. Example:"
    print_green_msg "$0 itan2-mmc"
    exit 3
fi

mkdir -p buildroot/dl

TOP_DIR=${PWD}
BUILDROOT=${PWD}/buildroot

cd project

PROJECT=${PWD}

rm -fr buildroot/configs
mkdir -p buildroot/configs
cd buildroot
cp -f ../board/defconfig configs/project_defconfig

rm -f output/build/linux-custom/.stamp_built output/build/linux-custom/.stamp_*_installed

LINK_LIST="arch board boot Config.in docs linux Makefile.legacy support toolchain Config.in.legacy dl fs Makefile make.sh package system utils"

for i in $LINK_LIST
do
    rm -f $i
    ln -sr ${BUILDROOT}/$i $i
done

if [ -n "$CLEAN" ]; then
    if [ "$CLEAN" = "all" ]; then
	print_blue_msg "Cleaning all ..."
	rm -fr output
    else
	print_blue_msg "Fast cleaning ..."
	for p in linux uboot busybox
	do
	    rm -fr output/build/${p}-*
	done
    fi
    ./make.sh project_defconfig
fi

[ ! -f .config ] && ./make.sh project_defconfig

print_blue_msg "Building buildroot ..."
./make.sh

cd ../
rm -fr images
ln -s buildroot/output/images images

cd ${TOP_DIR}

print_blue_msg "DONE."
