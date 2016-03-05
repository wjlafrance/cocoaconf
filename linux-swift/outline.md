# Linux and Swift, CocoaConf Chicago 2016

Target audience: OS X pro, never touched Linux

## Create a VM

- Host: ubuntu-15.10 desktop x64
- Hypervisor: VMware Workstation 12
- Guest: ubuntu-14.04.4 server LTS x64
- 30GB HDD, 2048MB RAM, 1 processor, 2 cores

## Why Ubuntu?

- Marco Arment: ["Linux distributions are an unfortunate oversupply of paralyzing choices. The easiest path is to learn one major distribution very well and use it everywhere. You want conservative, slow-moving, and very popular."](https://marco.org/2014/03/27/web-hosting-for-app-developers)
- Debian also suitable but not as popular.
- iOS devs are familiar with StackOverflow. If they have server issues, head over to askubuntu or serverfault.

## Conventions

All commands will start with the name of the machine you're supposed to run them on, and whether they're being run as root. `$` prefixes non-root commands and `#` prefixes root / sudo commands.

## Install Ubuntu

1. Select language
1. Select "install Ubuntu"
1. Select language again
1. Auto-detect keyboard layout (it's probably 'us')
1. Enter your hostname (I'm using 'northcarolina')
1. Enter account details (your personal identity - this is a sudoer but not the admin user)
1. Don't encrypt home directory (for now - advanced topic)
1. Detect time zone (US/Chicago if you're at CocoaConf)
1. Partiton: Guided - use entire disk
1. No proxy (unless you need one, in which case you probably know)
1. Install security updates automatically (your choice, really)
1. Choose OpenSSH server
1. Install GRUB into MBR
1. You're installed! Continue to reboot.

## First-boot configuration

1. Login to the terminal using the credentials you supplied earlier
1. Check your IP address: `vm$ ifconfig`
1. Secure up! (Optional)
	- `vm# ufw allow 22; ufw enable` allow SSH port and enable firewall
	- `host$ scp ~/.ssh/id_rsa.pub username@172.16.95.129:pubkey.pub`
	- `vm$ mkdir -p ~/.ssh && cat ~/pubkey.pub >> ~/.ssh/authorized_keys2`
	- `vm# vim /etc/ssh/sshd_config`, change PermitRootLogin to `no`, uncomment PasswordAuthentication and change to `no`
	` `vm# service ssh restart`
1. At this point you can switch to SSHing in from your host

## View Logs

- `vm$ tail /var/log/ufw`
- `vm$ tail /var/log/apache2/*`

