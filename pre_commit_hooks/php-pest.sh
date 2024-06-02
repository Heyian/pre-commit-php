#!/usr/bin/env bash

# Bash Pest Task Runner
#
# Exit 0 if no errors found
# Exit 1 if errors were found
#
# Requires
# - php
# - pest
#
# Arguments
# - None

# Plugin title
title="Pest Task Runner"

# Possible command names of this tool
local_command="pest --parallel"
vendor_command="vendor/bin/pest"
global_command="pest"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

echo -e "${bldwht}Running command ${txtgrn} ${exec_command}"
command_result=`eval $exec_command`
if [[ $command_result =~ FAILURES ]]
then
    hr
    echo "Failures detected in unit tests..."
    hr
    echo "$command_result"
    exit 1
fi
exit 0
