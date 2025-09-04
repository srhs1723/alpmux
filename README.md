# Alpmux

Alpmux provides a way to run an emulated Alpine Linux environment within Termux on Android. It uses QEMU to create a virtual machine for Alpine, giving you a lightweight and powerful Linux distribution on your mobile device.

## Features

*   **Full-fledged Linux Environment**: Run a complete Alpine Linux environment on your Android device.
*   **Lightweight**: Alpine Linux is a minimal and resource-efficient distribution.
*   **Easy to Install**: A simple installation script to get you started.
*   **Seamless Integration**: Optionally, autostart the Alpine environment with your Termux sessions.

## Installation

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/<your-username>/<your-repo-name>.git
    cd <your-repo-name>
    ```

2.  **Run the Installation Script**:
    ```bash
    bash install.sh
    ```
    This will install the necessary dependencies (QEMU), download the Alpine Linux ISO, and create a virtual disk image.

3.  **Install Alpine Linux**:
    Run the installation script for Alpine:
    ```bash
    bash start-alpine-install.sh
    ```
    This will boot up the Alpine installer. Follow these steps:
    *   Log in as `root` (no password).
    *   Run the `setup-alpine` command.
    *   Follow the on-screen instructions to install Alpine. A standard installation is fine.
    *   When the installation is complete, run the `poweroff` command to shut down the VM.

## Usage

Once you have installed Alpine Linux, you can start the environment with the following command:

```bash
bash start-alpine.sh
```

This will boot up your Alpine Linux VM. You can log in with the user you created during the installation.

### SSH Access

The Alpine environment is configured to forward port 2222 on your local device to port 22 in the VM. This means you can SSH into your Alpine instance from Termux:

```bash
ssh <your-user>@localhost -p 2222
```

## Autostart

If you want the Alpine environment to start automatically every time you open a new Termux session, you can use the `setup-autostart.sh` script:

```bash
bash setup-autostart.sh
```

This will add a command to your `.bashrc` file to launch `start-alpine.sh` automatically.

### Disabling Autostart

To disable autostart, you can edit your `.bashrc` file (`nano ~/.bashrc`) and remove the following lines:

```bash
# Alpmux autostart
sh /path/to/your/repo/start-alpine.sh
```

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.
