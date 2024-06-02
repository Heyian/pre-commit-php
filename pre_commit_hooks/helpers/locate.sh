################################################################################
#
# Locate the command from a list of options
#
################################################################################

# Final location of the executable that we found by searching
exec_command=""

#Verify if running in a Sail environment
sail_running=""
if docker ps --filter "name=laravel.test" --filter "status=running" | grep -q "laravel.test"; then
    sail_running=1
else
    sail_running=0
fi

# Sail command
sail_command="sail $local_command"
# A phar file will need to be called by php
prefixed_local_command="php $local_command"

if sail_running=1; then
    exec_command=$sail_command
elif [ -f "$vendor_command" ]; then
    exec_command=$vendor_command
elif hash $global_command 2>/dev/null; then
    exec_command=$global_command
elif [ -f "$local_command" ]; then
    exec_command=$prefixed_local_command
else
    echo -e "${bldred}No valid ${title} found!${txtrst}"
    echo "Please have one available as one of the following:"
    echo " * $sail_command"
    echo " * $local_command"
    echo " * $vendor_command"
    echo " * $global_command"
    exit 1
fi
