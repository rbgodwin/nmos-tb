# An NMOS Test Bed Infrastructure as Code ISAC Implementation

## Introduction

This repository contains an implementation of an NMOS Testbed. 

The code uses Terraform to create the following:   

- Instance 1 - AWS Linux running a 
DNS Service (BIND9) configured for a NMOS deployment along with a
Wireguard VPN Server.

- Instance 2 - AWS Linux running 
[Easy-NMOS](https://github.com/rhastie/easy-nmos) Docker Containers for Sony nmos-cpp RDS and Nodes
  
- Security Groups for Access to
SSH and 
NMOS Reference Broadcast Controller

- Configuration Files that setup the DNS, Wireguard, RDS, and NMOS Nodes


## Acknowledgements

This work is based on opensource contributions from many AMWA NMOS participants. The author gratefully acknowledges contributors to the following repos
 
- The AMWA Network Media Open Specification [NMOS](https://www.amwa.tv/nmos-overview) family of APIs, Best Current Practices, and HOW-TO documents.  
- The Sony [nmos-cpp](https://github.com/sony/nmos-cpp) opensource NMOS implementations for RDS and Nodes. 
- The [Easy-NMOS](https://github.com/rhastie/easy-nmos) starter kit.
  

## Areas of Interest for Future Activity

The implementation is designed to be extended. Development is ongoing, with the following areas of interest 

Ideas for the project:

- Add AMWA NMOS API [Test Suite](https://github.com/AMWA-TV/nmos-testing)
- Add reference media NMOS nodes that can generate actual video,audio, ancillary flows
- Add in items to implement NMOS Security Best Current Practices [BCP-003](https://specs.amwa.tv/bcp-003/)
  
## Contributing

We welcome bug reports, feature requests and contributions to the implementation and documentation.
Please have a look at the simple [Contribution Guidelines](CONTRIBUTING.md). 

Note: The Contribution Guide follows the recommendations for contributing originally developed as part of the Sony [nmos-cpp](https://github.com/sony/nmos-cpp) repo.

## AMWA and NMOS Reference

For more information about AMWA, NMOS and the Networked Media Incubator, please refer to <http://amwa.tv/>.

