# USAGE : changes software name in any .sh file within the current path with recursivity
# the first argument of the script is the current name and version of the software
# the second argument of the script is the new name and version of the software

# example : ./change_soft_version.sh qiime2_2020.2.sif qiime2_2021.8.sif

old_name="$1"
new_name="$2"
find ./ -type f -name "*.sh" -exec sed -i "s/${old_name}/${new_name}/g" {} +