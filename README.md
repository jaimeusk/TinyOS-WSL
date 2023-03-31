# TinyOS-WSL
This guide will provide you a simple way to get **TinyOS** on your **WSL** (Windows on Linux) working with the USB's of your PC using **usbipd**.

This guide is based on the instructions that you can find in the [TinyOS official Wiki](http://tinyos.stanford.edu/tinyos-wiki/index.php/Installing_From_Source).

## Prerequisites
1. **[Install WSL2 on your Windows PC](https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-3---enable-virtual-machine-feature)**

2. **Install Ubuntu-18.04 on your WSL.**
> (This guide is made using this distribution, I can't ensure it works with others distros)

> (I tried to made this on Debian 11 "bullseye" and I couldn't make it work, so if you find the way to make it work, just let me know it please)

As administrator, run on your windows terminal or PowerShell and then, restart your PC.
```
wsl --install -d Ubuntu-18.04
```

3. **[Install USBIPD-WIN on your Windows PC](https://learn.microsoft.com/en-us/windows/wsl/connect-usb) to get support for connect USB devices to your Ubuntu on WSL.**

If you have Windows Package Manager _(winget)_ you can install usbipd-win running the command:
```
winget install --interactive --exact dorssel.usbipd-win
```

4. **Run your Ubuntu-18.04 using the command:**
```
wsl -d Ubuntu-18.04
```

5. **Once you are on Ubuntu, update and upgrade your distribution. `apt update` and `apt upgrade`.**
> With root permissions (using root user or sudo)

6. **To run the usbipd on the ubuntu side, you have to install the following packages:**

> With root permissions 
```
apt install linux-tools-generic hwdata
```

> Run the next command
```
update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/*-generic/usbip 20
```

7. Once you have this installed on your ubuntu while you still running it, go to a Windows Terminal with admin permissions and run `usbipd wsl list` to list the usb devices connected to your host machine.


8. Run the following command to attach the desired usb to the WSL instance.

> The `--distribution Ubuntu-18.04` is used when you have more than one wsl instance running, to ensure that you attach the usb to the desired instance.

```
usbipd wsl attach --busid <bus-id> [--distribution Ubuntu-18.04]
```

9. Go to your Ubuntu WSL Instance and run `lsusb` to check that you have the usb attached correctly.

## Installing TinyOS from sources

1. **Install nesC from sources**
  - Get the prerequisites _ _(With root permissions)_ _

```
apt install automake emacs bison flex gperf git
apt install openjdk-8-jdk-headless

```
  - Get the source from GitHub repo:

> I sugest to locate all on /opt/nesc/
```
git clone https://github.com/tinyos/nesc.git
```

  - Run the normal build procedure
```
cd nesc
./Bootstrap
./configure
make
make install
```

2. **Install TinyOS from sources**

> I sugest to locate all on /opt/tinyos-main/

  - Get the prerequisites of TinyOS
```
apt install gcc-msp430
```

  - Get the sources of TinyOS
```
git clone https://github.com/tp-freeforall/prod
```

```
mv prod tinyos-main
cd tinyos-main
./Bootstrap
./configure
make
make install
```
