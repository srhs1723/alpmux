# Alpmux

Alpmux provides a way to run a customized, emulated Alpine Linux environment within Termux on Android. It uses QEMU to create a virtual machine for Alpine, giving you a lightweight and powerful Linux distribution on your mobile device.

This version of Alpmux includes a build script to create a modified Alpine ISO with a custom banner and the community repository enabled by default. It also sets up a separate virtual disk for your personal data.

## Features

*   **Custom Alpine ISO**: Build a personalized Alpine ISO with a custom banner.
*   **User Data Disk**: A separate virtual disk for your data, keeping it isolated from the OS.
*   **Full-fledged Linux Environment**: Run a complete Alpine Linux environment on your Android device.
*   **Easy to Install**: Scripts to automate the installation and setup.

## Installation

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/srhs1723/alpmux.git
    cd alpmux
    ```

2.  **Run the Installation Script**:
    ```bash
    bash install.sh
    ```
    This will:
    *   Install all necessary dependencies (QEMU, build tools).
    *   Run `build-iso.sh` to create a modified Alpine ISO (`alpmux-alpine.iso`).
    *   Create two virtual disks: `alpine.qcow2` for the OS and `userdata.qcow2` for your data.

3.  **Install Alpine Linux**:
    Run the installation script for Alpine. This will boot from the **modified** `alpmux-alpine.iso` that you created in the previous step.
    ```bash
    bash start-alpine-install.sh
    ```
    *   Log in as `root` (no password). You should see the custom Alpmux banner as confirmation that you are using the modified ISO.
    *   Run `setup-alpine` and follow the on-screen instructions.
    *   When asked to choose a disk, select `vda` to install Alpine on. Use the `sys` mode.

4.  **Set up the User Data Disk**:
    During the installation, after the main setup is complete, you need to format and prepare the user data disk.

    *   **Format the disk**: The user data disk is `vdb`. Format it as a `vfat` filesystem:
        ```sh
        mkfs.vfat /dev/vdb
        ```
    *   **Mount and configure fstab**:
        Create a mount point:
        ```sh
        mkdir /userdata
        ```
        Add an entry to `/etc/fstab` to auto-mount it on boot. Edit the file `/etc/fstab` (e.g., `vi /etc/fstab`) and add the following line:
        ```
        /dev/vdb   /userdata   vfat   defaults   0   0
        ```
    *   After you have finished the setup, run `poweroff`.

## Usage

Once you have installed Alpine Linux, you can start the environment with:

```bash
bash start-alpine.sh
```

This will boot up your Alpine Linux VM. Your `/userdata` partition will be automatically mounted.

## Autostart

If you want the Alpine environment to start automatically every time you open a new Termux session, you can use the `setup-autostart.sh` script.

```bash
bash setup-autostart.sh
```

This will add a command to your `.bashrc` file to launch `start-alpine.sh` automatically. To disable autostart, you can edit your `.bashrc` file and remove the Alpmux autostart lines.

## License

This project is licensed under the Apache License 2.0. See the `LICENSE` file for details.
