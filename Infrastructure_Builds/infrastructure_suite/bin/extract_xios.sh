#!/usr/bin/env bash
#
# NAME: extract_xios.sh
#
# DESCRIPTION: Extracts XIOS from a FCM repository
#
# ENVIRONMENT VARIABLES (COMPULSORY):
#    XIOSPATH
#    XIOS_REV
#    XIOS_URL
#    XIOS_VERSION
#


if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <local-xios-source-path>" >&2
    exit 2
fi

: "${XIOSPATH:?Set XIOSPATH to the destination path}"

XIOS_SOURCE=$(realpath -e -- "$1") || {
    echo "Local XIOS source path does not exist: $1" >&2
    exit 1
}
XIOS_DEST=$(realpath -m -- "$XIOSPATH") || exit 1

if [[ ! -d "$XIOS_SOURCE" ]]; then
    echo "Local XIOS source is not a directory: $XIOS_SOURCE" >&2
    exit 1
fi

# Avoid deleting the source or copying a directory into itself.
case "$XIOS_SOURCE/" in "$XIOS_DEST/"* )
    echo "XIOSPATH must not contain the source directory" >&2
    exit 1
esac
case "$XIOS_DEST/" in "$XIOS_SOURCE/"* )
    echo "XIOSPATH must not be inside the source directory" >&2
    exit 1
esac

rm -rf -- "$XIOS_DEST"
mkdir -p -- "$XIOS_DEST"
cp -a -- "$XIOS_SOURCE"/. "$XIOS_DEST"/ || exit 1
XIOSPATH=$XIOS_DEST


######### Code for fcm co below.
# rm -rf $XIOSPATH
# echo 'Attempting to checkout with the command'
# echo "${XIOS_URL}/${XIOS_VERSION}@${XIOS_REV}"
# fcm co $XIOS_URL/$XIOS_VERSION@$XIOS_REV

# XIOS_VERSION_BASE="$(basename $XIOS_VERSION)"
# mv $XIOS_VERSION_BASE $XIOSPATH

# if [[ "$XIOS_REV" == "1873" ]]; then
#    sed -i 's/#include <mpi.h>/#include <stdint.h>\n#include <mpi.h>/g' $XIOSPATH/src/mpi.hpp
# fi

# #End of script test
# ls $XIOSPATH
# [ $? -eq 0 ] || exit 1


