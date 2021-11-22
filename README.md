# An NMOS Test Bed Infrastructure as Code ISAC Implementation

## Introduction

This repository contains an implementation of an NMOS Testbed. 

The code uses Terraform to create the following:   

# Instance 1 - AWS Linux running a 
- DNS Service (BIND9) configured for a NMOS deployment.
- Wireguard VPN Server.

# Instance 2 - AWS Linux running 
- [Easy-NMOS](https://github.com/rhastie/easy-nmos) Docker Containers for Sony nmos-cpp RDS and Nodes
  
For more information about AMWA, NMOS and the Networked Media Incubator, please refer to <http://amwa.tv/>.
 
### Getting Started With NMOS

The [Easy-NMOS](https://github.com/rhastie/easy-nmos) starter kit allows the user to launch a simple NMOS setup with minimal installation steps.
It relies on nmos-cpp to provide an NMOS Registry and a virtual NMOS Node in a Docker Compose network, along with the AMWA NMOS Testing Tool and supporting services. Easy-NMOS is also a great first way to explore the relationship between NMOS services before building nmos-cpp for yourself.

### Creating Your Own NMOS Devices

This implementation uses Sony's [nmos-cpp](https://github.com/sony/nmos-cpp) opensource NMOS implementation. Sony's implementation is used many venders to implement NMOS JT-NM Badged products. 

## Agile Development

[<img alt="JT-NM Tested 03/20 NMOS & TR-1001-1" src="Documents/images/jt-nm-tested-03-20-registry.png?raw=true" height="135" align="right"/>](https://jt-nm.org/jt-nm_tested/)

The nmos-tb infrastructure, like the NMOS Specifications, is intended to be always ready, but steadily developing. One of the goals of the project is to provide the code used to create virtual workshops between the AMWA NMOS collaborators and to serve as a place to fork off new types of infrastructure while at the same time continuing to evolve.

### Areas of Interest for Future Activity

The implementation is designed to be extended. Development is ongoing, with the following areas of interest 

Ideas for the project:

- Add AMWA NMOS API [Test Suite](https://github.com/AMWA-TV/nmos-testing)
- Add reference media NMOS nodes that can generate actual video,audio, ancillary flows
- Add in items to implement [BCP-00]3(https://specs.amwa.tv/bcp-003/)
  
## Contributing

We welcome bug reports, feature requests and contributions to the implementation and documentation.
Please have a look at the simple [Contribution Guidelines](CONTRIBUTING.md).

Thank you for your interest!

