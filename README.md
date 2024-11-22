OpenVPN daemon setup for configuring vpn connection to its own linux network
namespace.

# Dependencies

* `setcuruser` script from [network-hardening](https://github.com/user827/network-hardening/blob/main/bin/setcuruser)
* [Network hardening sysctls](https://github.com/user827/network-hardening/blob/main/sysctls.conf)

# Configure
- Copy aurtemplate/PKGBUILD to root and make sure ./configure has correct
  parameters in it.
- `makepkg --install --syncdeps <thepackage>`
- Do the necessary configurations as written in the installation output.
- Enable and start the openvpn service
- The vpn network is now accessible in its own namespace named `vpn`.

# Usage
To run a command in vpn net namespace, you can use the provided `nse` command
e.g
```
nse wget www.google.com
```
