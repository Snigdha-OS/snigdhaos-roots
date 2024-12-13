# Snigdha OS Roots

Snigdha OS Roots is the foundational configuration repository for Snigdha OS, a lightweight, highly customizable Linux distribution based on Arch Linux and the Linux Zen Kernel. This repository contains essential files and scripts that define the core setup for Snigdha OS, providing a solid foundation for further customization and system management.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

Snigdha OS Roots is designed to be part of the Snigdha OS ecosystem, providing default configurations, system utilities, and essential components that ensure a seamless and streamlined user experience. This repository includes various scripts, environment configurations, and core tools required to set up and maintain a stable Snigdha OS installation.

## Features

- **Minimal Base System**: Focuses on providing a lightweight setup with only essential packages installed.
- **Custom Scripts**: Includes setup and configuration scripts to personalize the system.
- **System Configuration**: Includes default system configuration files like `~/.bashrc`, `~/.xinitrc`, and more.
- **AUR Integration**: Seamlessly integrates AUR helpers like `yay` for easy package installation from the Arch User Repository.
- **Security Enhancements**: Implements security-focused configurations by default for better system integrity.

## Installation

To install and set up Snigdha OS Roots, follow these steps:

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/Snigdha-OS/snigdhaos-roots.git
   ```

2. Change to the `snigdhaos-roots` directory:
   ```bash
   cd snigdhaos-roots
   ```

3. Copy the configuration files to their respective locations:
   ```bash
   cp -r .config ~/
   cp .bashrc ~/
   cp .xinitrc ~/
   ```

4. Ensure you have the required system dependencies installed. If you’re running an Arch-based distribution, you can use `pacman` or an AUR helper like `yay` to install the necessary packages:
   ```bash
   sudo pacman -S <required-packages>
   ```

## Configuration

After installation, you can customize Snigdha OS Roots to suit your needs:

- **Bash Configuration**: Modify the `.bashrc` file for your shell settings.
- **X11 Configuration**: Configure `.xinitrc` for your window manager and desktop environment setup.
- **System Tweaks**: Review and edit system configurations located in the `.config` directory for services and system behavior adjustments.

## Usage

Once installed and configured, you can start using Snigdha OS Roots to further customize your environment:

- To start X11 with your window manager, use the `startx` command.
- Configure your system services and apply custom configurations based on your requirements.
- Use the provided scripts to manage and update your system.

For additional usage instructions and system management, refer to the `docs` folder or review the individual configuration files.

## Contributing

We welcome contributions to Snigdha OS Roots. To contribute:

1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Submit a pull request with a detailed description of the changes.

For larger contributions or ideas, please open an issue to discuss it with the maintainers first.

## License

Snigdha OS Roots is licensed under the [MIT License](LICENSE). See the LICENSE file for more details.
