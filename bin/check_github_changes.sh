#!/bin/bash

# Define colors for different categories
task_color="\033[33m"       # Yellow for tasks
password_color="\033[34m"   # Blue for passwords
archive_color="\033[35m"    # Magenta for archives
home_color="\033[38;5;208m" # Orange for home
reset_color="\033[0m"

# Synchronize tasks
echo -en "${task_color}Tasks: ${reset_color}"
git -C .task pull

# Synchronize password-store
echo -en "${password_color}Passwords: ${reset_color}"
pass git pull

# Syncronize archives
echo -en "${archive_color}Archives: ${reset_color}"
git -C arch pull

# Synchronize home
echo -en "${home_color}Home: ${reset_color}"

# Define your GitHub repository URL
github_repo="$github/home"

# Check for changes in the remote repository
git remote update > /dev/null 2>&1

# Check if there are any changes
if git status -uno | grep -q 'Your branch is behind'; then
    # Changes found, prompt the user
    read -p "Found changes in the remote repository. Do you want to pull? (Y/N): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        # User confirmed, pull changes
        git pull "$github_repo"
        reset
    else
        echo "Changes not pulled."
    fi
else
    echo "No changes found in the remote repository."
fi

#track me!
