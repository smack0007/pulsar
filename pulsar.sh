#!/bin/bash
set -e

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

PULSAR_PATH="$(dirname $(realpath "${BASH_SOURCE[0]}"))"
PULSAR_DATA_PATH="${HOME}/.pulsar/data"
PULSAR_BIN_PATH="${PULSAR_PATH}/bin"
PULSAR_PACKAGES_PATH="${PULSAR_PATH}/packages"
PULSAR_TASKS_PATH="${PULSAR_PATH}/tasks"

pulsar_array_contains() {
	local array=$1[@]
	
	for value in "${!array}"; do
		if [ "${value}" == "$2" ]; then
			return 0
		fi
	done

	return 1
}

pulsar_array_join() {
	local array=$1[@]

  for value in "${!array}"; do
		printf %s%s "${value}" "$2"
	done
}

pulsar_error() {
	printf "${RED}ERROR:${ENDCOLOR} $1\n"
	exit 1
}

pulsar_info() {
	printf "${BLUE}INFO:${ENDCOLOR} $1\n"
}

pulsar_list_packages() {
	local packages=(${PULSAR_PACKAGES_PATH}/*.sh)

	for package in "${packages[@]}"; do
		echo "$(basename ${package} .sh)"
	done
}

pulsar_list_tasks() {
	local tasks=(${PULSAR_TASKS_PATH}/*.task)

	for task in "${tasks[@]}"; do
		echo "$(basename ${task} .task)"
	done
}

pulsar_remove_blank_lines() {
	echo -e $1 | sed '/^$/d'
}

mkdir -p "${PULSAR_DATA_PATH}"
# Ensure pulsar.tasks exists
if [ ! -f "${PULSAR_DATA_PATH}/pulsar.tasks" ]; then
	touch "${PULSAR_DATA_PATH}/pulsar.tasks"
fi
