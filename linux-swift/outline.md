# Linux and Swift, CocoaConf Chicago 2016

Target audience: OS X pro, never touched Linux

## My VM environment

- Host: OS X 10.11.4
- Hypervisor: VMware Fusion 8.1
- Guest: ubuntu-15.10 server x64 (recommended disk / RAM / processors)

## Why Ubuntu?

- Marco Arment: ["Linux distributions are an unfortunate oversupply of paralyzing choices. The easiest path is to learn one major distribution very well and use it everywhere. You want conservative, slow-moving, and very popular."](https://marco.org/2014/03/27/web-hosting-for-app-developers)
- Ubuntu offers long-term support releases every 24 months, supported for 60 months (although these instructions do not use the current LTS).
- Ubuntu is widely available on cloud hosting platforms: EC2, DigitalOcean, Linode, etc.

## Conventions

All commands are to be executed on the Linux VM (either directly or via SSH) unless otherwise specified. `$` prefixes commands being run as the user and `#` prefixes commands that must be run as root (type `sudo` before the command).

## Install Ubuntu

1. In VMWare Fusion menu: File -> New
1. Select [`ubuntu-15.10-server-amd64.iso`](http://www.ubuntu.com/download) as your installation disk image
1. Check "Use Easy Install", do not check "Make your home folder available to the virtual machine"
1. Click "Finish". The installation is fully unattended and you'll arrive at the login screen.

Alternately, provision an Ubuntu 15.10-based VPS on your favorite hosting service. They may have a different set of default packages and instructions may vary.

## First-boot configuration and security

- Log in using the credentials you supplied earlier
- `$ ifconfig` to find your IP address
- `# apt-get install openssh-server` to install SSH server
- `# apt-get install vim` to install your editor of choice (Optional)
- `host$ scp ~/.ssh/id_rsa.pub lafrance@192.168.176.131:pubkey.pub` (NB: replace the username and IP address)
- `$ mkdir -p ~/.ssh; cat pubkey.pub >> ~/.ssh/authorized_keys; rm pubkey.pub`
- Secure up! (Optional)
	+ `# ufw allow 22` to allow SSH connections
	+ `# ufw allow 80` to allow HTTP connections
	+ `# ufw enable` to enable the firewall
	+ Open `/etc/ssh/sshd_config` in your editor of choice (as root, `sudo vim /etc/ssh/sshd_config`), find `PermitRootLogin` and set it to no, find `PasswordAuthentication` and set it to no
	+ `# service ssh restart` to pick up config changes
- Log out of the VM's terminal by typing `exit` and SSH from your Mac's terminal. You'll be much more comfortable with modern amenities such as scrolling.

## Install Swift

- Find the latest package URLs [here](https://swift.org/download/) and alter the following commands accordingly. These are current as of CocoaConf Chicago 2016.
- `# apt-get install clang libicu-dev`
- `$ cd ~`
- `$ wget https://swift.org/builds/swift-2.2-release/ubuntu1510/swift-2.2-RELEASE/swift-2.2-RELEASE-ubuntu15.10.tar.gz`
- Verify authenticity (Optional)
	+ `$ wget https://swift.org/builds/swift-2.2-release/ubuntu1510/swift-2.2-RELEASE/swift-2.2-RELEASE-ubuntu15.10.tar.gz.sig`
	+ `$ wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -`
	+ `$ gpg --verify swift-2.2-RELEASE-ubuntu15.10.tar.gz.sig`
	+ You'll likely see a warning: `This key is not certified with a trusted signature`. This is because GPG can't verify a full chain of trust. Since you downloaded the keys from `swift.org` via HTTPS you've verified that the keys are provided by Apple so this warning can be safely ignored.
	+ If you see a `BAD signature` warning stop what you're doing and read the instructions [here](https://swift.org/download/#using-downloads). Something may have been compromised.
- `$ tar xzf swift-2.2-RELEASE-ubuntu15.10.tar.gz`
- `# mkdir -p /opt/apple`
- `# mv swift-2.2-RELEASE-ubuntu15.10 /opt/apple`
- `# ln -s /opt/apple/swift-2.2-RELEASE-ubuntu15.10 /opt/apple/swift-current`
- `# update-alternatives --install /usr/bin/swift swift /opt/apple/swift-current/usr/bin/swift 1`
- `# update-alternatives --install /usr/bin/swiftc swiftc /opt/apple/swift-current/usr/bin/swiftc 1`

## Run a few tests

- `$ swift` to open a REPL.
	+ Type `print("hello world")` and see if you get the expected result.
	+ Type `import Foundation`. Foundation currently isn't included in the Swift binary distribution so this will error.
- Test the compiler
	+ `$ echo 'print("Hello world")' > helloworld.swift`
	+ `$ swiftc helloworld.swift`
	+ `$ ./helloworld`

## Put Swift on the web!

- Install Apache web server and enable CGI
	+ `# apt-get install apache2`
	+ `# a2enmod cgi`
	+ `# service apache2 restart`
- Create a basic interpreted script
	+ `$ wget https://gist.github.com/wjlafrance/31df15769c9e385c15aa/raw/af26a36f041869e879aea14d48a37b870270b896/swift-interp`
	+ `# cp swift-interp /usr/lib/cgi-bin`
	+ `# chmod +x /usr/lib/cgi-bin/swift-interp` to set the execute bit
- Compile and install a executable
	+ `$ wget https://gist.github.com/wjlafrance/31df15769c9e385c15aa/raw/af26a36f041869e879aea14d48a37b870270b896/swift-compiled.swift`
	+ `$ swiftc swift-compiled.swift -o swift-compiled`
	+ `# cp swift-compiled /usr/lib/cgi-bin`
- Test these URLs in a browser (NB: use the IP reported by `ifconfig`)
	+ `http://http://192.168.176.131/cgi-bin/swift-interp`
	+ `http://http://192.168.176.131/cgi-bin/swift-compiled`

## Next steps?

- Build Swift from source
- Migrate to Ubuntu 16.04 LTS ([to be released April 21st 2016](https://wiki.ubuntu.com/XenialXerus/ReleaseSchedule))
- Framework to handle CGI environment (interpreting incoming headers and arguments, handle sending responses)
- Serving JSON either using [NSJSONSerialization](https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSJSONSerialization.swift) (serialization is `NSUnimplemented` as of 2016-03-25) or [PMJSON](https://github.com/postmates/PMJSON)

## Further reading

- [RFC-3875](https://tools.ietf.org/html/rfc3875) - Common Gateway Interface
- [apple/swift](https://github.com/apple/swift/blob/master/README.md) - instructions for compiling Swift yourself
- [apple/swift-corelibs-foundation](https://github.com/apple/swift-corelibs-foundation) - watch on Github
- [Ask Ubuntu](https://askubuntu.com) - StackExchange site for Ubuntu users
- [ServerFault](https://serverfault.com) - StackExchange site for system administration

## Feedback / Issues

If you run into issues feel free to contact me either on [Twitter](https://twitter.com/wjlafrance) or via email (address is [on my profile](https://github.com/wjlafrance)). If you found this useful, say hi!
