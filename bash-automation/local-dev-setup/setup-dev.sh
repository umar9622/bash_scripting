#!/usr/bin/bash

echo -e "\n===================================="
echo "Checking installed tools and versions"
echo -e "====================================\n"

# Command names
tools=("git" "python3" "docker" "node" "npm" "psql" "curl" "uv")

# Corresponding Arch Linux package names
packages=("git" "python" "docker" "nodejs" "npm" "postgresql" "curl" "uv")

mis_tools=()

for i in "${!tools[@]}"; do
    tool="${tools[$i]}"
    package="${packages[$i]}"

    if command -v "$tool" &> /dev/null; then
        version=$("$tool" --version 2>&1 | head -n 1)
        echo -e "\n✅ $tool is installed: '$version'"
    else
        echo -e "\n⚠️ $tool is missing"
        mis_tools+=("$package")
    fi
done

if (( ${#mis_tools[@]} == 0 )); then
    echo -e "\nEverything is installed.....😎"
else
    echo -e "\n--------------------------------------\n"

    read -r -n 1 -p "Missing tools found 😥. Ready to install? (y/n): " confirm
    echo

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        if sudo pacman -S --needed "${mis_tools[@]}"; then

            # Verify dependencies again
            all_installed=true

            for check_again in "${tools[@]}"; do
                if command -v "$check_again" &> /dev/null; then
                    echo "✅ $check_again is available."
                else
                    all_installed=false
                    echo "❌ $check_again is still missing."
                fi
            done

            if [[ "$all_installed" == true ]]; then
                echo -e "\n✅Dependencies installed successfully."
            else
                echo -e "\n❌ $check_again is still missing."
            fi

        else
            echo -e "\nDependency installation failed."
        fi
    else
        echo -e "\nInstallation skipped by user."
    fi
fi

echo -e "\n--------------------------------------\n"
echo "Creating project directory and cloning project from GitHub...📂"

prj_dir="$HOME/Projects-main"
repo_dir="$prj_dir/nginx"

mkdir -p "$prj_dir"

if [[ -d "$repo_dir" ]]; then
    echo -e "\nRepository already exists at '$repo_dir'. Skipping clone."
else
    if git clone https://github.com/umar9622/nginx.git "$repo_dir"; then
        echo -e "\n✅ Git cloned successfully inside '$prj_dir'!"
    else
        echo -e "\n❌ Git clone failed."
    fi
fi

echo -e "\n--------------------------------------\n"
