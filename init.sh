#!/usr/bin/env bash
#
#    __                          __
#   / /____ ___ ____  ___  ___ _/ /       This file is provided to you by https://github.com/tegonal/oss-template
#  / __/ -_) _ `/ _ \/ _ \/ _ `/ /        Copyright 2024 Tegonal Genossenschaft
#  \__/\__/\_, /\___/_//_/\_,_/_/         It is licensed under Creative Commons Zero v1.0 Universal
#         /___/                           Please report bugs and contribute back your improvements
#
#                                         Version: v0.1.0-SNAPSHOT
###################################
set -euo pipefail
shopt -s inherit_errexit
unset CDPATH

projectDir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null && pwd 2>/dev/null)"
readonly projectDir

if ! [[ -v dir_of_tegonal_scripts ]]; then
	dir_of_tegonal_scripts="$projectDir/lib/tegonal-scripts/src"
	source "$dir_of_tegonal_scripts/setup.sh" "$dir_of_tegonal_scripts"
fi
sourceOnce "$dir_of_tegonal_scripts/utility/log.sh"

printf "Please choose your license:\n(1) EUPL 1.2\n(2) AGPL 3\n(3) Apache 2.0\n(4) CC0 1.0 Universal\nYour selection (default (1) EUPL 1.2): "
read -r choice

if [[ -z "$choice" ]]; then
	choice=1
fi

if [[ choice -eq 1 ]]; then
	licenseUrl="https://joinup.ec.europa.eu/collection/eupl/eupl-text-11-12"
	licenseShortName="EUPL 1.2"
	licenseFullName="European Union Public Licence v. 1.2"
	cp "$projectDir/EUPL.LICENSE.txt" "$projectDir/LICENSE.txt"
elif [[ choice -eq 2 ]]; then
	licenseUrl="https://www.gnu.org/licenses/agpl-3.0.en.html"
	licenseShortName="AGPL 3"
	licenseFullName="GNU Affero General Public License v3"
	cp "$projectDir/AGPL.LICENSE.txt" "$projectDir/LICENSE.txt"
elif [[ choice -eq 3 ]]; then
	licenseUrl="https://www.apache.org/licenses/LICENSE-2.0"
	licenseShortName="Apache 2.0"
	licenseFullName="Apache License, Version 2.0"
	cp "$projectDir/Apache.LICENSE.txt" "$projectDir/LICENSE.txt"
elif [[ choice -eq 4 ]]; then
	licenseUrl="https://creativecommons.org/publicdomain/zero/1.0/"
	licenseShortName="CC0 1.0"
	licenseFullName="Creative Commons Zero v1.0 Universal"
	cp "$projectDir/CC0.LICENSE.txt" "$projectDir/LICENSE.txt"
else
	die "the selection %s is invalid, chose one between 1 and 4" "$choice"
fi

defaultOrgName="Tegonal Genossenschaft"
printf "Please insert the organisation name (default %s): " "$defaultOrgName"
read -r orgName
if [[ -z "$orgName" ]]; then
	orgName="$defaultOrgName"
fi

defaultEmail="info@tegonal.com"
printf "Please insert the organisation email (default %s): " "$defaultEmail"
read -r orgEmail
if [[ -z "$orgEmail" ]]; then
	orgEmail="$defaultEmail"
fi

defaultOrgNameGithub="tegonal"
printf "Please insert the github organisation name (default %s): " "$defaultOrgNameGithub"
read -r orgNameGithub
if [[ -z "$orgNameGithub" ]]; then
	orgNameGithub="$defaultOrgNameGithub"
fi

printf "Please insert the project name: "
read -r projectName
tmpName="${projectName//-/_}"
projectNameUpper="${tmpName^^}"
tmpName="${projectName// /-}"
defaultProjectNameGithub="${tmpName,,}"

printf "Please insert the github project name (default %s): " "${defaultProjectNameGithub}"
read -r projectNameGithub
if [[ -z "$projectNameGithub" ]]; then
	projectNameGithub="${defaultProjectNameGithub}"
fi


licenseBadge="[![$licenseShortName](https://img.shields.io/badge/%E2%9A%96-${licenseShortName// /%220}-%230b45a6)]($licenseUrl \"License\")"
licenseLink="[$licenseFullName]($licenseUrl)"

find "$projectDir" -type f \
	-not -path "$projectDir/.gt/**/lib/**" \
	-not -path "$projectDir/lib/**" \
	-not -name "init.sh" \
	-not -name "cleanup.yml" \
	-not -name "gt-update.yml" \
	-not -name "CODE_OF_CONDUCT.md" \
	\( -name "*.md" -o -name "*.yaml" -o -name "*.yml" -o -name "*.sh" \) \
	-print0 |
	while read -r -d $'\0' file; do
		PROJECT_NAME_GITHUB="$projectNameGithub" \
		PROJECT_NAME_UPPER="${projectNameUpper}" \
		PROJECT_NAME="$projectName" \
		ORG_NAME_GITHUB="$orgNameGithub" \
		ORG_NAME="$orgName" \
		ORG_EMAIL="$orgEmail" \
		LICENSE_BADGE="$licenseBadge" \
		LICENSE_LINK="$licenseLink" \
		LICENSE_FULL_NAME="$licenseFullName" \
		YEAR=$(date +%Y) \
			perl -0777 -i \
			-pe "s@PROJECT_NAME_GITHUB@\$ENV{PROJECT_NAME_GITHUB}@g;" \
			-pe "s@PROJECT_NAME_UPPER@\$ENV{PROJECT_NAME_UPPER}@g;" \
			-pe "s@PROJECT_NAME@\$ENV{PROJECT_NAME}@g;" \
			-pe "s@ORG_NAME_GITHUB@\$ENV{ORG_NAME_GITHUB}@g;" \
			-pe "s@ORG_NAME@\$ENV{ORG_NAME}@g;" \
			-pe "s@ORG_EMAIL@\$ENV{ORG_EMAIL}@g;" \
			-pe "s@LICENSE_BADGE@\$ENV{LICENSE_BADGE}@g;" \
			-pe "s@LICENSE_LINK@\$ENV{LICENSE_LINK}@g;" \
			-pe "s@LICENSE_FULL_NAME@\$ENV{LICENSE_FULL_NAME}@g;" \
			-pe "s@YEAR@\$ENV{YEAR}@g;" \
			"$file"
	done

find "$projectDir" -maxdepth 1 -name "*.LICENSE.txt" -print0 |
	while read -r -d $'\0' license; do
		rm "$license"
	done

logSuccess "initialised the repository, please follow the remaining steps in README.md"

rm "$projectDir/init.sh"
