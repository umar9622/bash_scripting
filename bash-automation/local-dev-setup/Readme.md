# Local Development Environment Setup

A simple Bash automation script to prepare a local development environment on **Arch Linux**.

The script checks required development tools, installs missing dependencies using Pacman, verifies their availability, and clones a GitHub project into the local Projects directory.

## Features

- Checks whether required development tools are installed.
- Displays installed tool versions.
- Identifies missing dependencies.
- Asks for user confirmation before installing missing packages.
- Installs dependencies using Pacman.
- Verifies dependencies after installation.
- Creates the project directory automatically.
- Clones the GitHub repository if it does not already exist.
- Skips cloning if the repository is already present.

## Requirements

- Arch Linux
- Bash
- Pacman
- Internet connection
- Git

## Tools Checked

| Tool | Arch Linux Package |
|---|---|
| Git | `git` |
| Python 3 | `python` |
| Docker | `docker` |
| Node.js | `nodejs` |
| npm | `npm` |
| PostgreSQL Client (`psql`) | `postgresql` |
| cURL | `curl` |
| uv | `uv` |

## Project Structure

```text
local-dev-setup/
├── setup-dev.sh
└── README.md
```

## Usage

**1. Clone this repository**

```bash
git clone <your-repository-url>
```

**2. Navigate to the project directory**

```bash
cd local-dev-setup
```

**3. Give execution permission**

```bash
chmod +x setup-dev.sh
```

**4. Run the script**

```bash
./setup-dev.sh
```

The script checks installed tools and asks for confirmation before installing any missing dependencies.

## Installation Behaviour

- If all required tools are installed, the script skips dependency installation.
- If tools are missing, it asks the user whether to install them.
- If the user confirms, Pacman installs the corresponding packages.
- The script checks tool availability again after installation.
- The GitHub project is cloned into `~/Projects-main/nginx`.
- If that repository directory already exists, cloning is skipped.

## Important Notes

- This project currently targets Arch Linux only.
- Docker is checked as a command-line tool. The script does not currently verify whether the Docker daemon is running or whether an Nginx container exists.
- Nginx is not installed through Pacman because the development project uses Docker for Nginx.
- The script requires sudo privileges when installing packages.

## Purpose

This project is built to practise Bash scripting and Linux automation through a practical development environment setup.

The focus is on Bash fundamentals, including:

- Arrays and loops
- Conditional statements
- Functions and command checks
- User input with `read`
- Package management with Pacman
- Exit-status checking
- Directory and Git operations

---

**Status:** In Development

**Platform:** Arch Linux

**Language:** Bash
