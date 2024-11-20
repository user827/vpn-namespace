OpenVPN daemon setup for configuring vpn connection to its own linux network
namespace.

# Configure
- Copy aurtemplate/PKGBUILD to root and configure its ./configure variables
- makepkg --install --syncdeps
- Do the necessary configurations as written in the installation output.
- Enable and start the openvpn service
- The vpn network is now accessible in its own namespace named `vpn`.
