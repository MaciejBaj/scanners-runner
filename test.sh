#!/bin/bash
additional_options=""

if [ ! -z "${1}" ]; then
	additional_options+="--resolution ${1}"
fi

if [ ! -z "${2}" ]; then
	additional_options+=" -x ${2}"
fi

if [ ! -z "${3}" ]; then
	additional_options+=" -y ${3}"
fi

if [ ! -z "${4}" ]; then
	additional_options+=" --gamma-table ${4}"
fi

if [ ! -z "${5}" ]; then
	additional_options+=" --brightness ${5}"
fi

echo "$additional_options"