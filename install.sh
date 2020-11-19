#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
# /volume1/docker is shared folder path
INSTALL_DIR="/volume1/docker"
if [ ! -d "${INSTALL_DIR}" ]; then
	echo "The installation directory does not exist."
	exit
fi
function PrerequisitesCheck()
{
# https://docs.sonarqube.org/latest/requirements/requirements/
	value=$(sysctl vm.max_map_count)
	if (( "${value##* }" < 524288 )); then
		sysctl -w vm.max_map_count=524288
		echo "Write vm.max_map_count=524288"
	fi
	value=$(sysctl fs.file-max)
	if (( "${value##* }" < 131072 )); then
		sysctl -w fs.file-max=131072
		echo "Write fs.file-max=131072"
	fi
	value=$(ulimit -n)
	if (( ${value} < 131072 )); then
		ulimit -n 131072
		echo "Write ulimit -n 131072"
	fi
	value=$(ulimit -u)
	if (( ${value} < 8192 )); then
		ulimit -u 8192
		echo "Write ulimit -u 8192"
	fi
}
function CreateDirectory()
{
	cd "${INSTALL_DIR}"
	if [ -d "sonarqube" ]; then
		echo "sonarqube directory exists, so delete it."
		rm -rf sonarqube
	fi
	mkdir -p sonarqube
	cd sonarqube
	mkdir -p data
	mkdir -p extensions
	mkdir -p logs
	mkdir -p postgres
	mkdir -p postgres_data
	mkdir -p temp
	cd ../
	chmod 777 sonarqube -R
}
function Install()
{
	if [ -f ".env" ]; then
		rm -f .env
	fi
	echo "INSTALL_DIR=${INSTALL_DIR}/sonarqube" >> .env
	docker-compose up -d
}
PrerequisitesCheck
echo "Prerequisites OK"
CreateDirectory
echo "Directory OK"
Install
echo "Install OK"