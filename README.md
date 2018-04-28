# cisco_aci Puppet Module

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Background](#background)
    * [Cisco Application Centric Infrastructure](#cisco-application-centric-infrastructure)
    * [Cisco Application Centric Policy Infrastructure Controller](#cisco-application-centric-policy-infrastructure-controller)
    * [Cisco Application Centric Infrastructure Controller REST API](#cisco-application-centric-infrastructure-controller-rest-api)
    * [Puppet Device](#puppet-device)
1. [Solution Overview](#solution-overview)
1. [Setup - The basics of getting started with aci_puppet_module](#setup)
    * [Setup Puppet Server](#puppet-server)
      * [Install Puppet Module](#install-puppet-module)
      * [Configure Puppet Manifest](#configure-puppet-manifest)
        * [Configure Proxy Node in the Manifest](#configure-proxy-node-in-the-manifest)
        * [Configure APIC Node in the Manifest](#configure-apic-node-in-the-manifest)   
    * [Setup Puppet Agent](#puppet-agent)
    * [Setup Puppet Agent Authentication](#puppet-agent-authentication)
    * [Quick Start Configuration - Cut, Paste, and Run](#quick-start-with-aci_puppet_module)
      * [On `Puppet Server`](#on-puppet-server)
      * [On `Puppet Proxy Agent Device` Execution](#on-puppet-proxy-agent-device-execution)
      * [On `Puppet Proxy Agent Device` Validation](#on-puppet-proxy-agent-device-validation)
1. [Usage - Configuration options and additional functionality](#usage)
    * [Using Puppet Resource Types](#using-puppet-resource-types)
    * [Using Puppet Component Classes](#using-puppet-component-classes)
    * [Using Custom Facts](#using-custom-facts)
    * [Using Examples](#using-examples)
    	* [Resource Based Manifest](#resource-based-manifest)
      * [Hiera Driven Class Based Manifest](#hiera-driven-class-based-manifest)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
   * [How Puppet Types are mapped to ACI Managed Objects](#how-puppet-types-are-mapped-to-aci-managed-objects)
   * [Puppet Provider to APIC Inter Working](#puppet-provider-to-apic-inter-working)
   * [Supported Puppet Resources](#supported-puppet-resources)
1. [Troubleshooting](#troubleshooting)
	* [Issues during setup](#issues_during_setup)
		* [cisco_aci Module Installation](#cisco_aci_module_installation)
	* [Issues during execution of puppet agent](#issues_during_execution_of_puppet_agent)
	* [Issues during execution of puppet device](#issues_during_execution_of_puppet_device)
		* [Enabling Debugging](#enabling_debugging)
		* [Manual Execution of puppet device](#manual_execution_of_puppet_device)
		* [Examine Debugging Messages](#examine_debugging_messages)
		* [Examine Exceptions from APIC](#examine_exceptions_from_apic)
	* [Issues during the usage of the cisco_aci module](#issues_during_the_usage_of_the_cisco_aci_module)
	* [APIC Issues](#apic_issues)
1. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module allows network administrators to use Puppet's infrastructure to provision Cisco's ACI Fabric via the Cisco APIC controller. This module requires the use of a `Puppet Agent` running as a proxy and leverages the `puppet device` construct to send REST provisioning requests to the APIC controller. Puppet Agent version `5.5` or later is required when using this module.

This document assumes that you are already familiar with Puppet. If you are not familiar with Puppet, refer to [Puppet Course Catalog](https://learn.puppet.com/course-catalog) for different training options.

## Module Description

This module bundles a set of Puppet Types, Providers and Classes along with sample manifests for effective network management. Several automated tests are included in the module for quick validation. The resources and capabilities provided by this module will grow with contributions from Cisco, Puppet Labs and the Open Source Community. Refer to the [Resource Support Matrix](#supported-puppet-resources) for a list if currently supported Types and Providers.

This GitHub repository contains the latest version of the `cisco_aci` module source code. Supported versions of the `cisco_aci` module are available at Puppet Forge. Refer to [SUPPORT.md](./SUPPORT.md) for additional details.

## Background

### Cisco Application Centric Infrastructure
Cisco Application Centric Infrastructure (ACI) is an innovative architecture that radically simplifies, optimizes, and accelerates the entire application deployment lifecycle. Cisco ACI uses a holistic systems-based approach, with tight integration between physical and virtual elements, an open ecosystem model, and innovation-spanning application-specific integrated circuits (ASICs), hardware, and software. This unique approach uses a common policy-based operating model across ACI-ready network, and security elements (computing, storage in future), overcoming IT silos and drastically reducing costs and complexity [[source](https://www.cisco.com/c/dam/en/us/products/collateral/cloud-systems-management/aci-fabric-controller/at-a-glance-c45-729864.pdf)]. For additional details refer to the following [[link](https://www.cisco.com/c/en/us/solutions/data-center-virtualization/application-centric-infrastructure/index.html)].

### Cisco Application Centric Policy Infrastructure Controller
The Cisco Application Policy Infrastructure Controller (APIC) is the main architectural component of the Cisco ACI solution. It is the unified point of automation and management for the Cisco ACI fabric, policy enforcement, and health monitoring. The Cisco APIC is a centralized clustered controller that optimizes performance, supports any application anywhere, and unifies operation of physical and virtual environments. The controller manages and operates a scalable multi-tenant Cisco ACI fabric. The Cisco APIC is responsible for tasks ranging from fabric activation, maintenance of switch firmware, network policy configuration and instantiation. Cisco APIC is completely removed from the data path. This means that the fabric can still forward traffic even when communication with the APIC is lost. The APIC itself is delivered as an appliance and will typically be run as three or more appliances for performance and availability [[source](https://www.cisco.com/c/dam/en/us/products/collateral/cloud-systems-management/aci-fabric-controller/at-a-glance-c45-729864.pdf)].

### Cisco Application Centric Infrastructure Controller REST API
The Application Policy Infrastructure Controller (APIC) REST API is a programmatic interface that uses REST architecture. The API accepts and returns HTTP (not enabled by default) or HTTPS messages that contain JavaScript Object Notation (JSON) or Extensible Markup Language (XML) documents. You can use any programming language to generate the messages and the JSON or XML documents that contain the API methods or Managed Object (MO) descriptions. Standard REST methods are supported on the API, which includes POST, GET, and DELETE operations through HTTP. The POST and DELETE methods are idempotent, meaning that there is no additional effect if they are called more than once with the same input parameters. The GET method is nullipotent, meaning that it can be called zero or more times without making any changes (or that it is a read-only operation). Payloads to and from the REST interface can be encapsulated through either XML or JSON encoding [[source](https://www.cisco.com/c/en/us/td/docs/switches/datacenter/aci/apic/sw/2-x/rest_cfg/2_1_x/b_Cisco_APIC_REST_API_Configuration_Guide/b_Cisco_APIC_REST_API_Configuration_Guide_chapter_01.html)]. This Puppet Module uses the JSON encoding over the REST interface for provisioning the APIC. Individual Managed Objects are documented at the following [[link](https://developer.cisco.com/docs/apic-mim-ref/)].

### Puppet Device
For devices such as the APIC that do not include an embedded `Puppet Agent`, Puppet provides the `puppet device` [[link](https://puppet.com/docs/puppet/latest/man/device.html)] command. This command requests certificates, collects facts, retrieves and applies catalogs, and stores reports for each device defined in `device.conf` [[link](https://puppet.com/docs/puppet/latest/config_file_device.html)]. This command can be executed manually or scheduled to run periodically. For additional details please refer to the corresponding documentation.

## Solution Overview
Puppet requires the use of a proxy agent along with the `puppet device` command to provision devices where the `Puppet Agent` is not installed on the device. This solution follows the recommended approach and is illustrated in the following diagram.

![1](docs/puppet_aci_solution_overview.png)

Network Administrators follow the typical Puppet workflow to install the `cisco_aci` module on the `Puppet Server` and configure an agent (ex: a Linux or Windows system) to act as the proxy for the APIC. The configuration of the proxy agent includes running the `Puppet Agent` periodically. The `Puppet Agent` running on the proxy retrieves its catalog from the `Puppet Server` and synchronizes this module and its libraries as necessary. The Puppet Manifest for the proxy agent configures its `device.conf` file and schedules execution of the `puppet device` command.

The Puppet Manifest for the APIC includes the desired configuration generated by the Puppet Types and Classes included in the `cisco_aci` Module. The configuration of the proxy agent includes running the `puppet device`  command periodically. When the `puppet device` command executes on the proxy agent, it requests the catalog for the APIC and executes the appropriate Puppet Providers. The Puppet Providers generate a JSON payload and send that payload to the APIC via its REST API.

![2](docs/puppet_aci_control_flow_overview.png)

## Setup

### Puppet Server
This document assumes that a `Puppet Server` has already been installed and configured properly. If a `Puppet Server` does not exist in your network please follow the guidelines from Puppet to set one up [[Puppet Server Setup](https://puppet.com/docs/puppetserver/5.3/install_from_packages.html)]

#### Install Puppet Module
Network administrators need to install the `cisco_aci` Puppet Module on the `Puppet Server`. For details on the installation of Puppet Modules on the `Puppet Server` please refer to the following documentation:[[Puppet: Installing Modules](https://puppet.com/docs/puppet/5.3/modules_installing.html)].
```bash

# If you have an older module installed, you need to uninstall it.
puppet module uninstall cisco-cisco_aci --ignore-changes

# Install the new module from the Puppet Forge.
puppet module install cisco-cisco_aci

# Install the tkishel-puppet_device module from the Puppet Forge.
puppet module install tkishel-puppet_device
```
Please note that installation of the `cisco_aci` module will automatically install the [`tkishel-puppet_device` module from Puppet Forge](https://forge.puppet.com/tkishel/puppet_device) as a dependency along with any modules that [`tkishel-puppet_device` depends on](https://forge.puppet.com/tkishel/puppet_device/dependencies). For additional details on this module please refer to its documentation on the Puppet Forge [[link](https://forge.puppet.com/tkishel/puppet_device)]. That module automates the configuration of the `device.conf` file and provides an option to schedule execution of the `puppet device` command on the proxy agent.

#### Configure Puppet Manifest
Network administrators must define a Puppet Manifest which configures both the proxy agent and the APIC device. This manifest must define two nodes: one for the proxy agent and the other for the APIC device.

##### Configure Proxy Node in the Manifest
To configure the proxy agent, another Puppet Module will be used. For additional details on that module please refer to it's documentation [[link](https://forge.puppet.com/tkishel/puppet_device)].

```puppet
# Example:
node 'proxy-agent.example.com' {
  puppet_device {'apic.example.com':
    type             => 'apic',  # Specifies the type of the device in device.conf.
    url              => 'https://username:password@apic.example.com', # Specifies the URL of the device in device.conf.
    run_interval     =>  30,     # Execute `puppet device --target apic.example.com` every 30 minutes.
  }
}
```

This manifest will configure the `device.conf` on the proxy agent device (by default located in /etc/puppetlabs/puppet/) and is used by the `puppet device` command. Additionally, it will create a Cron or Scheduled Task resource to schedule the `puppet device` command to run at the specified interval.

##### Configure APIC Node in the Manifest
To provision the ACI Fabric via the APIC, network administrators can use the resource defined in the `cisco_aci` module and apply them to the APIC node from the manifest. Administrators can use the component Puppet Classes or Puppet Types to manage the resources on the APIC. Here is an example for configuring a tenant on the APIC. The first option uses a Puppet component class cisco_aci::classes::cisco_aci_fvtenant that is essentially a wrapper over the Puppet Type `cisco_aci_fvtenant`. The second example makes use of the Puppet Type directly.

```puppet
# Example Option-1: Use Puppet component class
node 'apic.example.com' {
  class {"cisco_aci::classes::cisco_aci_fvtenant":
      fvtenant_ensure => 'present',
      fvtenant_name   => 'example_tenant',
      fvtenant_descr  => 'This is an example tenant',
   }
}
```
```puppet
# Example Option-2: Use Puppet Type resource
node 'apic.example.com' {
  cisco_aci_fvtenant { "demo_cisco_aci_fvtenant":
      ensure => 'present',
      name   => 'example_tenant',
      descr  => 'This is an example tenant',
   }
}
```

### Puppet Agent
Any Linux or Windows system with proper network connectivity to the `Puppet Server` and the APIC can function as the proxy agent. Please ensure that `Puppet Agent` version `5.5` or greater is already [installed and configured](#https://puppet.com/docs/puppet/5.5/install_linux.html) on the node. After the installation of the `Puppet Agent`, the administrator can run the `puppet agent` command manually or periodically using the typical Puppet workflow.

When the `Puppet Agent` runs, it synchronizes modules and obtains the catalog for the proxy agent. It also uses the `puppet_device` [resource](#https://forge.puppet.com/tkishel/puppet_device) module to (i) configure `device.conf` and (ii) schedule execution of the `puppet device` command using a Linux Cron Job or Windows Scheduled Task. The `puppet device` command requests certificates, collect facts, retrieves catalogs, and stores reports on behalf of the APIC, and applies catalogs to provision the APIC.

Since `puppet device` is executed as a background task, it is detached from the standard output. Therefore you will not see any debug or error messages in the console window. To ensure that everything is setup correctly, it is advised to run the `puppet device --verbose` command manually at least once and address any errors.

When the `Puppet Agent` and the `puppet device` command are scheduled to run periodically, the administrator should configure a Puppet reporting service to the collect logs. To setup reporting for Puppet PE please refer to the following [link](https://puppet.com/docs/puppet/5.5/reporting_about.html). Open source Puppet users can refer to the appropriate guides to setup the reporting tool.

Please note that `puppet device` command manages the APIC and will not synchronize changes to modules on the `Puppet Server` with the proxy agent. Therefore, it is essential that `puppet agent` be scheduled to run periodically to synchronize changes to modules from the `Puppet Server` to the proxy agent.

### Puppet Agent Authentication
No configuration of the APIC is necessary. Please follow the typical workflow for `Puppet Agent` authentication. For example, a network administrator may decide to explicitly sign each certificate request on the `Puppet Server` or decide to configure the `Puppet Server` to autosign certificate requests. For details on the certificate signing and configuration please refer to the Puppet documentation [[link](https://puppet.com/docs/puppet/5.5/ssl_autosign.html)].

Please note that certificate requests from both the proxy agent and APIC must be signed (or autosigned).

```puppet
# Example, on the Puppet Server, in /etc/puppetlabs/puppet/autosign.conf
*.example.com
```

### Quick Start with aci_puppet_module

For this quick start guide assume the following:
  * **Puppet Server:** Hostname is `puppet-server` with DNS name `puppet-server.example.com`.
  * **Puppet Proxy Agent Device:** Hostname is `proxy-agent` with DNS name `proxy-agent.example.com`.
  * **APIC Device:** with DNS name `apic.example.com`.

#### On `Puppet Server`

* Check Puppet version (minimum requirement: version 5.2 or later)
```bash
root@puppet-server:~ puppetserver --version
```
* Install cisco_aci module
```bash
# Choose one of the following:
root@puppet-server:~ puppet module install cisco-cisco_aci #Install from Puppet Forge
# OR:
root@puppet-server:~ puppet module install /<path>/cisco-cisco_aci-<version>.tar.gz #From local tar
```
**NOTE:** This will automatically install any dependent modules.

* (Optional) Restart Puppet Server
```bash
root@puppet-server:~ service puppetserver restart
```
* Update the Puppet Manifest

Contents of `/etc/puppetlabs/code/environments/production/manifests/site.pp`
```puppet
node 'proxy-agent.example.com' {
  puppet_device {'apic.example.com':
    type             => 'apic',  # Specifies the type of the device in device.conf.
    url              => 'https://username:password@apic.example.com', # Specifies the URL of the device in device.conf.
    run_interval     =>  30,     # Execute `puppet device --target apic.example.com` every 30 minutes.
  }
}
node 'apic.example.com' {
  cisco_aci_fvtenant {'test_tenant1':
    ensure => 'present',
    name   => 'test_tenant1',
    descr  => 'My test tenant',
  }
  cisco_aci_fvap { 'test_app1':
    ensure   => 'present',
    name     => 'test_app1',    # Instance Identifier
    fvtenant => 'test_tenant1', # Parent cisco_aci_fvtenant Identifier
    descr    => 'My test application profile tenant test_tenant1',
  }
  cisco_aci_fvaepg { 'test_epg1':
    ensure    => 'present',
    name      => 'test_epg1',    # Instance Identifier
    fvtenant  => 'test_tenant1', # Parent cisco_aci_fvtenant Identifier
    fvap      => 'test_app1',    # Parent cisco_aci_fvap Identifier
    descr     => 'My EPF test_epg1 in the application profile test_app1 in tenant test_tenant1',
  }
  cisco_aci_fvbd { 'test_bd1':
    ensure    => 'present',
    name      => 'test_bd1',     # Instance Identifier
    fvtenant  => 'test_tenant1', # Parent cisco_aci_fvtenant Identifier
    descr     => 'My bridge domain in tenant test_tenant1',
  }
  cisco_aci_fvctx { 'test_vrf1':
    ensure    => 'present',
    name      => 'test_vrf1',    # Instance Identifier
    fvtenant  => 'test_tenant1', # Parent cisco_aci_fvtenant Identifier
    descr     => 'My VRF context in tenant test_tenant1',
  }
  cisco_aci_fvsubnet { 'subnet1':
    ensure    => 'present',
    ip        => '20.20.20.1/24', # Instance Identifier
    fvtenant  => 'test_tenant1',  # Parent cisco_aci_fvtenant Identifier
    fvbd      => 'test_bd1',      # Parent cisco_aci_fvbd Identifier
    descr     => 'My subnet subnet1 in bridge domain test_bd1 in tenant test_tenant1',
  }
  cisco_aci_vzbrcp { 'test_contract1':
    ensure    => 'present',
    name      => 'test_contract1', # Instance Identifier
    fvtenant  => 'test_tenant1',   # Parent cisco_aci_fvtenant Identifier
    descr     => 'My contract test_contract1 on my tenant test_tenant1',
  }
  cisco_aci_vzfilter { 'test_filter1':
    ensure    => 'present',
    name      => 'test_filter1', # Instance Identifier
    fvtenant  => 'test_tenant1', # Parent cisco_aci_fvtenant Identifier
    descr     => 'My filter test_filter1',
  }
  cisco_aci_vzsubj { 'test_subject1':
    ensure    => 'present',
    name      => 'test_subject1',  # Instance Identifier
    fvtenant  => 'test_tenant1',   # Parent cisco_aci_fvtenant Identifier
    vzbrcp    => 'test_contract1', # Parent cisco_aci_vzbrcp Identifier
    descr     => 'My subject test_subject1 for contract test_contract1 in tenant test_tenant1',
  }
  cisco_aci_vzentry { 'test_filter_entry1':
    ensure    => 'present',
    name      => 'test_filter_entry1', # Instance Identifier
    fvtenant  => 'test_tenant1',       # Parent cisco_aci_fvtenant Identifier
    vzfilter  => 'test_filter1',       # Parent cisco_aci_vzfilter Identifier
    descr     => 'My filter entry test_filter_entry1 for filter test_filter1 in tenant test_tenant1',
  }
  # Explicitly declare resources relationships.
  Cisco_aci_fvtenant['test_tenant1'] ->
  Cisco_aci_fvap['test_app1'] ->
  Cisco_aci_fvaepg['test_epg1'] ->
  Cisco_aci_fvbd['test_bd1'] ->
  Cisco_aci_fvctx['test_vrf1'] ->
  Cisco_aci_fvsubnet['subnet1'] ->
  Cisco_aci_vzbrcp['test_contract1'] ->
  Cisco_aci_vzfilter['test_filter1'] ->
  Cisco_aci_vzsubj['test_subject1'] ->
  Cisco_aci_vzentry['test_filter_entry1']
}
```
* (optional) Ensure that Agents are authorized
```puppet
# If using autosign, ensure that /etc/puppetlabs/puppet/autosign.conf contains the following.
*.example.com
```
#### On `Puppet Proxy Agent Device` Execution

* Check Puppet version (minimum requirement: version 5.5 or later)
```bash
root@proxy-agent:~ puppet --version
```
* Configure the `/etc/puppetlabs/puppet/puppet.conf` with the puppet server information.
```bash
[main]
  server = puppet-server.example.com
```
* Run `Puppet Agent`
```bash
root@proxy-agent:~ puppet agent -t
```
* Run `puppet device`
```bash
root@proxy-agent:~ puppet device --debug --trace
```
* (optional) Run `puppet device --target`
```bash
root@proxy-agent:~ puppet device --debug --trace --target apic.example.com
```

#### On `Puppet Proxy Agent Device` Validation

* Check configuration using the `puppet device --resource` command.
```puppet
root@proxy-agent:~# puppet device --verbose --target apic.example.com --resource cisco_aci_fvtenant
```
**NOTE:** The current implementation of `puppet device --resource` does not display the parent namevar identifiers.

* Check configuration using APIC GUI
Login to the APIC GUI to validate the configuration provisioned by Puppet. For convenience, the provider for this module generates a Puppet [Notice](#https://puppet.com/docs/puppet/5.5/function.html#notice) log message with the URL corresponding to the APIC GUI. The reference section of this document captures the URL format for offline reference.
```Puppet
# Example output
Notice: Cisco_aci_fvaepg[test_epg1](provider=cisco_aci): APIC GUI URI for provisioned resource https://apic.example.com/#bTenants:test_tenant1|uni/tn-test_tenant1/ap-test_app1/epg-[test_epg1]
```
Known Limitation: `Notice` messages are visible when executing the `puppet device` command directly. User will need to make use of a Puppet reporting tool.

## Usage

### Using Puppet Resource Types
The ACI fabric represents the physical and logical components as a Management Information Model (MIM), in a hierarchical management information tree (MIT). The information model is stored and managed by processes that run on the APIC. Each node in the tree represents a managed object (MO) or group of objects. MOs are abstractions of fabric resources. An MO can represent a concrete object, such as a switch, adapter, or a logical object, such as an application profile, endpoint group, or fault (for additional details refer to [ACI Policy Model](https://www.cisco.com/c/en/us/td/docs/switches/datacenter/aci/apic/sw/1-x/aci-fundamentals/b_ACI-Fundamentals/b_ACI-Fundamentals_chapter_010001.pdf))

This Puppet Module defines several Puppet Resource Types that correspond to several key configurable ACI Managed Objects exported by the APIC. Future versions of this module will be enhanced to add (i) additional attributes to Type and (ii) new Types on an as need basis. Note that Puppet is a configuration management tool therefore, this module will not attempt to add Puppet representation of non-configurable entities.

#### Puppet Type and Properties Naming Scheme
To keep the provisioning model predictable, this Puppet module derives the name of the Type and associated properties from the corresponding Managed Object. This approach removes the need for a `decoder ring` making the module easy to debug. The identifier for the Managed Object is defined as a Puppet `namevar`. Additional Puppet `namevars` are defined to capture the identity of the parent Puppet Types. The following diagram illustrates the naming scheme.

![3](docs/puppet_aci_type_to_mo_mapping.png)

#### Puppet Type dependency and Management Information Tree
Since the APIC organizes the Managed Objects in a tree structure, there are relationship dependencies between the corresponding Puppet Types. The dependencies between the types are documented at [type-dependency-tree.md](./docs/type-dependency-tree.md). The dependancies among the resources used in the manifest can be enforced using the Puppet chaining arrow model described in the following document [[link](https://puppet.com/docs/puppet/5.5/lang_relationships.html)].

To keep the provisioning simple, the resource types defined in this module require administrators to explicitly specify the values for the namevars (keys), instead of depending on the title patterns. The namevars associated with a Type can be grouped into two categories:

Category 1: namevar that identifies the parent resource type instance. <br />
Category 2: namevar that identifies the resource type being configured.

We recommend that the title pattern be set using the same value as the namevar that identifies the resource type being configured. Following diagram illustrates the concept.

![4](docs/puppet_type_usage.png)

#### Puppet Provider to APIC Inter Working
Puppet Providers in this module make use of several helper libraries to transform the user's intent from Puppet's DSL to JSON payload based on APIC REST API rules. The JSON REST request is then forwarded to a vendor specific implementation of Puppet's NetworkDevice class (called 'apic'). Following diagram illustrates the approach.

![4](docs/puppet_aci_type_interworking.png)

Puppet Types in this module define Puppet attributes using Puppet DSL. The corresponding providers maintain the knowledge of both Puppet attributes and their mapping to ACI Managed Objects. The Puppet Providers in this module  use a Ruby library to transform the Puppet operations into APIC REST API actions. The library uses the `Puppet attribute to Managed Object mapping` information in the Providers to build proper URLs and REST API payload in JSON format. It also maintains logic to extract data from APIC responses and populate the Puppet attributes. Aforementioned provider library invokes GET, POST and DELETE operation on the `Apic Network Device`. This device is Ruby child class of `Puppet::Util::NetworkDevice` and primarily serves as plug-in in to Puppet's `device` infrastructure. The `Apic Network Device` forwards requests to a Ruby library that implements the APIC REST API client logic. Following diagram illustrates the overall control flow.

![5](docs/puppet_provider_design_flow.png)

### Using Puppet Component Classes
For convenience this module includes  Puppet component classes that wrap around the Puppet Types supported by the module. These parameterized classes can be used as reference for defining Puppet Classes for specific use cases. Puppet Classes are singletons that may not be useful for all use cases; this module makes use of these classes for automated testing. The dependency between the classes are same as the corresponding Puppet Types [[type-dependency-tree.md](./docs/type-dependency-tree.md)].

These classes expose each Puppet Type attribute as a class parameter. Each class supports two additional optional parameters: override_ensure, override_descr. These optional parameters are primarily used for automated testing across a large number of classes.

One special Puppet class 'cisco_aci_all' is included among the classes [[link](./manifests/classes/cisco_aci_all.pp)]. This class makes use of all the Puppet Classes (except cisco_aci_rest) and is primarily used for demonstration.

### Using Custom Facts
This module exports several custom facts containing ACI Fabric Member information that can be leveraged within the Puppet Manifest.  The facts are collected using a DHCP client query sent to the APIC where the selection criteria specifies nodes that have a role of `leaf` or `spine`.

These custom facts can be accessed from within the Puppet Manifest using the typical Puppet workflow (https://puppet.com/docs/puppet/5.5/lang_facts_and_builtin_vars.html#the-factsfactname-hash).

Example:
```puppet
if ${facts['aci_fabric_members'][0]['SAL1814PTC6']['nodeRole'] == 'leaf' {
  # Perform Action
}
```
The `$facts['aci_fabric_members'][0]` is an array of nested Ruby hashes, where the serial number associated with fabric members are defined as keys and the value is a hash of different attributes related to the member. For example,
`$facts['aci_fabric_members'][0]['SAL1814PTC6']` is a hash with key-value pairs that describe properties of the fabric member `SAL1814PTC6`.

The following table describes facts that are collected for each ACI Fabric Member.

| Fact            | Description                             |
|-----------------|-----------------------------------------|
| capabilities    | Fabric Member Capabilities              |
| fabricId        | Fabric Identifier                       |
| id              | Serial Number                           |
| ip              | Node IP Address                         |
| model           | Fabric Member Model Number              |
| name            | Node Name                               |
| nameAlias       | Node Name Alias                         |
| nodeId          | Node Identifier                         |
| nodeRole        | Fabric Node Role                        |
| podId           | Fabric Pod Identifier                   |
| runningVer      | Firmware Version                        |
| status          | Fabric Member Status                    |
| supported       | Node Model Support Indication           |

An additional set of custom ruby functions is also provided that can be used to easily access the following information and act as examples for creating new custom functions if needed.

* Custom Function `cisco_aci::facts::fabric_member_get('count')`
    * Returns the total number of ACI Fabric members
* Custom Function `cisco_aci::facts::fabric_member_get('ids')`
    * Returns an `Array` of ACI Fabric Member IDs
* Custom Function `cisco_aci::facts::fabric_member_get('all')`
    * Returns complete `Hash` of all fabric member hashes.
* Custom Function `cisco_aci::facts::fabric_member_get({"SAL1814PTC6"=>"model"})`
    * Returns model number for fabric member `SAL1814PTC6`.
    * The value can be any data key that is available for fabric member `SAL1814PTC6`
* Custom Function `cisco_aci::facts::fabric_member_get({"SAL1814PTC6"=>"all"})`
    * Returns all `Hash` data for fabric member `SAL1814PTC6`.

A [sample manifiest](manifests/facts.pp) is provided with examples detailing function usage.

Here is the output that is generated when running the sample manifest.

```shell
[puppetserver] Scope(Class[Cisco_aci::Facts]) Number of ACI Fabric Members: 5
[puppetserver] Scope(Class[Cisco_aci::Facts]) ACI Fabric Members: [SAL1814PTC6, SAL1934MR08, SAL1815Q7ZT, SAL2014N5TK, SAL2004XMKM]
[puppetserver] Scope(Class[Cisco_aci::Facts]) Model number for SAL1814PTC6, N9K-C9396PX
[puppetserver] Scope(Class[Cisco_aci::Facts]) Model number for SAL1934MR08, N9K-C9372PX
[puppetserver] Scope(Class[Cisco_aci::Facts]) Model number for SAL1815Q7ZT, N9K-C9396PX
[puppetserver] Scope(Class[Cisco_aci::Facts]) Model number for SAL2014N5TK, N9K-C9336PQ
[puppetserver] Scope(Class[Cisco_aci::Facts]) Model number for SAL2004XMKM, N9K-C9336PQ
[puppetserver] Scope(Class[Cisco_aci::Facts]) ACI Fabric Member Data for Member: SAL1814PTC6
[puppetserver] Scope(Class[Cisco_aci::Facts])
  {
  "capabilities": "multi-pod-bringup",
  "fabricId": "1",
  "id": "SAL1814PTC6",
  "ip": "10.0.64.91/32",
  "model": "N9K-C9396PX",
  "name": "Leaf3",
  "nameAlias": "",
  "nodeId": "103",
  "nodeRole": "leaf",
  "podId": "1",
  "runningVer": "n9000-13.0(1k)",
  "status": "",
  "supported": "yes"
}
```

### Using Examples
#### Resource Based Manifest
This module includes sample Puppet Manifest fragments that configure different Puppet Types [[<module top>/examples/demo_resource_data/](./examples/demo_resource_data)]. To use one of the examples, please copy and paste the desired fragments into the proper location in your `site.pp` manifest file. When a resource type requires parents, please ensure that you are copying the corresponding samples to the right place in the hierarchy.

```puppet
# Proxy Agent Node Setup
node 'proxy-agent.example.com' {
  puppet_device {'apic.example.com':
    type             => 'apic',  # Specifies the type of the device in device.conf.
    url              => 'https://username:password@apic.example.com', # Specifies the URL of the device in device.conf.
    run_interval     =>  30,     # Execute `puppet device --target apic.example.com` every 30 minutes.
  }
}
# APIC Device Configuration

#Modify the APIC node specification in the site.pp to add bridge domain example
#Copy the content from
#1. <module top>/examples/demo_resource_data/cisco_aci_fvtenant_demo_resource_data.pp
#2. <module top>/examples/demo_resource_data/cisco_aci_fvbd_demo_resource_data.pp
node 'apic.example.com' {
  #
  #Demo Resource data for resource cisco_aci_fvtenant
  #
  cisco_aci_fvtenant { "test_tenant1":
    ensure => "present",
    name => "test_tenant1", #Instance Identifier
    descr => "My test tenant",
    name_alias => "test_tenant_1",
    owner_key => "admin_cisco",
    owner_tag => "cisco",
  }
  #
  #Demo Resource data for resource cisco_aci_fvbd
  #
  cisco_aci_fvbd { "test_bd1":
    ensure => "present",
    name => "test_bd1", #Instance Identifier
    fvtenant => "test_tenant1", #Parent cisco_aci_fvtenant Identifier
    arp_flood => "yes",
    descr => "My bridge domain in tenant test_tenant1",
    ep_clear => "no",
    ep_move_detect_mode => "",
    intersite_bum_traffic_allow => "no",
    intersite_l2_stretch => "no",
    ip_learning => "yes",
    limit_ip_learn_to_subnets => "yes",
    ll_addr => "::",
    mac => "00:22:BD:F8:19:FF",
    mcast_allow => "yes",
    multi_dst_pkt_act => "encap-flood",
    name_alias => "test_bd_1",
    optimize_wan_bandwidth => "no",
    owner_key => "admin_cisco",
    owner_tag => "cisco",
    type => "regular",
    unicast_route => "yes",
    unk_mac_ucast_act => "proxy",
    unk_mcast_act => "opt-flood",
    vmac => "not-applicable",
  }

  # Explicitly declare resources relationships. Refer to
  #<module top>/docs/type-dependency-tree.md for hierarchy
  Cisco_aci_fvtenant['test_tenant1'] ->
  Cisco_aci_fvbd['test_bd1']
}
```

#### Hiera Driven Class Based Manifest
A sample Puppet Manifest that uses all the Puppet classes in the module is located at: [<module top>/examples/demoall_manifest_hieradriven.pp](./examples/demoall_manifest_hieradriven.pp).

This sample manifest makes use of [Puppets built-in key-value configuration data lookup system called Hiera](https://puppet.com/docs/puppet/5.5/hiera_intro.html) to drive the manifest.

The corresponding Hiera datafile is located at [demo_hiera_data.yaml](./examples/demo_hiera_data.yaml).

To make use of this sample manifest, please follow these steps.

   * [`Puppet Server puppet-server.example.com`] Configure the `/etc/puppetlabs/puppet/hiera.yaml` file.
   ```yaml
   ---
   :backends:
     - yaml
   :yaml:
     :datadir: "/etc/puppetlabs/code/environments/%{::environment}/hieradata"
   :hierarchy:
     - "nodes/%{::trusted.certname}"
     - "virtual/%{::virtual}"
     - "common"
  ```
   * [`Puppet Server puppet-server.example.com`] Copy the demo_hiera_data.yaml to proper location in the hiera data hierarchy.
   ```bash
   root@puppet-server:~ cp examples/demo_hiera_data.yaml /etc/puppetlabs/code/environments/production/hieradata/common.yaml

   # Note, your location might differ but this is provided as a working example.
   ```
   * [`Puppet Server puppet-server.example.com`] Copy demoall_manifest_hieradata.pp to the site.pp on Puppet Manifest for the node and modify FQDN for the nodes.
   ```bash
   root@puppet-server:~ cp examples/demoall_manifest_hieradriven.pp /etc/puppetlabs/code/environments/production/manifests/site.pp

   # Note, your location might differ but this is provided as a working example.
   ````

## Reference

### Supported Puppet Resources
| Puppet Type         | ACI Managed Object   |  Puppet Namevars (keys)   |
|---------------------|----------------------|---------------------------
|[cisco_aci_fvtenant](lib/puppet/type/cisco_aci_fvtenant.rb)|   A tenant is a logical container for application policies that enable an administrator to exercise domain-based access control. <br /> **Documentation:** [`fvTenant`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvTenant.html) <br /> **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\> | **Instance Identifiers**  <br /> <ul><li>cisco_aci_fvtenant.name</li></ul>   |
|[cisco_aci_fvap](lib/puppet/type/cisco_aci_fvap.rb)|    An application profile defines the policies, services and relationships between endpoint groups. <br /> **Documentation:** [`fvAp`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvAp.html) <br />  **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/ap-<app profile name\>  | **Instance Identifiers**  <br /> <ul><li>cisco_aci_fvap.name</li></ul> <br /> **Parent Identifiers** <br /> <ul><li>cisco_aci_fvap.fvtenant</li></ul>|
|[cisco_aci_fvbd](lib/puppet/type/cisco_aci_fvbd.rb)|  A bridge domain (fvBD) represents a Layer 2 forwarding construct within the fabric.<br />  **Documentation:** [`fvBD`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvBD.html)  <br /> **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/BD-<bridge domain name\>    |**Instance Identifiers**  <br /> <ul><li>cisco_aci_fvbd.name</li></ul> <br /> **Parent Identifiers** <br /> <ul><li>cisco_aci_fvbd.fvtenant</li></ul>|
|[cisco_aci_vzbrcp](lib/puppet/type/cisco_aci_vzbrcp.rb)|  A contract in the policy model. <br /> **Documentation:** [`vzBrCP`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzBrCP.html) <br />  <br /> **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/brc-<contract name\>    |**Instance Identifiers**  <br /> <ul><li>cisco_aci_vzbrcp.name</li></ul><br /> **Parent Identifiers** <br /> <ul><li>cisco_aci_vzbrcp.fvtenant</li></ul>|
|[cisco_aci_fvctx](develop/lib/puppet/type/cisco_aci_fvctx.rb)|  A Virtual Routing and Forwarding (VRF) object or context is a tenant network. <br /> **Documentation:** [`fvCtx`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvCtx.html) <br />  **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/ctx-<bridge domain name\>   |**Instance Identifiers**  <br /> <ul><li>cisco_aci_fvctx.name</li></ul><br /> **Parent Identifiers** <br /> <ul><li>cisco_aci_fvctx.fvtenant</li></ul>|
|[cisco_aci_vzfilter](lib/puppet/type/cisco_aci_vzfilter.rb)|  Represents a Filter within the policy model. <br /> **Documentation:** [`vzFilter`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzFilter.html) <br />  **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/flt-<filter name\>   |**Instance Identifiers**  <br /> <ul><li>cisco_aci_vzfilter.name</li></ul><br />**Parent Identifiers** <br /><ul><li> cisco_aci_vzfilter.fvtenant</li></ul>|
|[cisco_aci_fvaepg](lib/puppet/type/cisco_aci_fvaepg.rb)|  An EPG is a managed object that is a named logical entity that contains a collection of endpoints.   <br /> **Documentation:** [`fvAEpg`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvAEPg.html) <br />  **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/ap-<application profile name\>/epg-\<EPG name\>  |**Instance Identifiers**  <br /> <ul><li>cisco_aci_fvaepg.name</li></ul> <br/> **Parent Identifiers** <br /><ul><li>cisco_aci_fvaepg.fvtenant</li><li>cisco_aci_fvaepg.fvap</li></ul>|
|[cisco_aci_fvsubnet](lib/puppet/type/cisco_aci_fvsubnet.rb)| Represents a subnet in the policy model. <br /> **Documentation:** [`fvSubnet`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-fvSubnet.html) <br /> **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/BD-<bridge doamin name\>/subnet-\<ip/mask\> |**Instance Identifiers**  <br /> <ul><li>cisco_aci_fvsubnet.ip</li></ul><br />**Parent Identifiers** <br /><ul><li>cisco_aci_fvsubnet.fvtenant</li><li>cisco_aci_fvsubnet.fvbd</li></ul>|
|[cisco_aci_vzsubj](lib/puppet/type/cisco_aci_vzsubj.rb)| Subject labels that are applied to EPGs. <br /> **Documentation:** [`vzSubj`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzSubj.html)  <br />  **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/brc-<contract name\>/subj-\<subject name\> |**Instance Identifiers**  <br /> <ul><li>cisco_aci_vzsubj.name</li></ul><br />**Parent Identifiers** <br /><ul><li>cisco_aci_vzsubj.fvtenant</li><li>cisco_aci_vzsubj.fvap</li></ul>|
|[cisco_aci_vzentry](lib/puppet/type/cisco_aci_vzentry.rb)| A filter entry is a combination of network traffic classification properties.  <br /> **Documentation:** [`vzEntry`](https://pubhub.devnetcloud.com/media/apic-mim-ref-311/docs/MO-vzEntry.html) <br />  **APIC GUI:** https://\<apic.example.com\>/#bTenants:\<tenant name\>\| uni/tn-\<tenant name\>/flt-<filter name\>/e-<entry name>|**Instance Identifiers**  <br /> <ul><li>cisco_aci_vzentry.name</li></ul><br />**Parent Identifiers** <br /><ul><li>cisco_aci_vzentry.fvtenant</li><li>cisco_aci_vzentry.vzfilter</li></ul>|

### Troubleshooting

The focus of this section is to present a high level approach to narrow down issues encountered during the usage of this module. Issues can be broadly categorized into five different buckets: (i) Issues during setup (ii) Issues during execution of `puppet agent` (iii) Issues during execution of `puppet device` (iv) Issues during the usage of the `cisco_aci` module and (v) Issues originating from APIC.

![6](docs/puppet_aci_troubleshooting_overview.png)

#### (0) Issues during setup
##### `cisco_aci` Module Installation
By default, the `puppet module install` command attempts to fetch modules from [Puppet Forge](https://forge.puppet.com/). If the puppet server sits behind a firewall, network administrators must either enable external network access or place the module in an accessible location within the firewall boundary. Refer to the `puppet module install` [documentation](https://puppet.com/docs/puppet/5.5/modules_installing.html) for additional details.

#### (1) Issues during execution of `puppet agent`
When administrators run `puppet agent -t` on the Linux server hosting the proxy agent, `Puppet Agent` exchanges certificates with the server, plugin syncs Puppet modules installed on the Puppet Server and fetches the catalog for the Linux server. This is a typical `Puppet Server` and `Puppet Agent` interaction. Follow the standard Puppet troubleshooting techniques to isolate the issue [[Puppet Troubleshooting](https://puppet.com/docs/pe/2017.3/troubleshooting/troubleshooting_communications_between_components.html)]. Few quick tips are listed below.
  * Ensure that the time between the server hosting `Puppet Server` and the Linux server hosting the `Proxy Puppet Agent` are synchronized
  * Ensure that the certificate exchange between the server and agent is successful.
    * `puppet agent --debug --trace` generates message that can help with troubleshooting
    * Executing `puppet cert list` on `Puppet Server` should list the FQDN associated with the Linux server (hosting proxy agent)
    * Examine the `puppetserver-access.log` and `puppetserver.log` on `Puppet Server` (default location: /var/log/puppetlabs/puppetserver)
    * Ensure the Puppet manifest on `Puppet Server` contains an entry for the Linux node serving as the proxy node.
    * If the optional module (tkishel-puppet_device)to help with management of `device.conf` for `puppet device` is used, it should create the configuration file in the `/etc/puppetlabs/puppet` directory. Ensure that this file has the desired configuration.

#### (2) Issues during execution of `puppet device`
When the `puppet device` command is executed manually or periodically, it exchanges certificates with the server on behalf of APIC and fetches the catalog for the APIC node. This is a typical `Puppet Server` and `Puppet Agent` interaction. Follow the standard Puppet troubleshooting techniques to isolate the issue [[Puppet Troubleshooting](https://puppet.com/docs/pe/2017.3/troubleshooting/troubleshooting_communications_between_components.html)]. For troubleshooting details on the `puppet device` command refer to the corresponding document. A few quick tips are listed below.
  * Ensure that the certificate exchange between the server and agent is successful.
    * `puppet device --debug --trace` generates message that can help with troubleshooting
    * Executing `puppet cert list` on `Puppet Server` should list the FQDN associated with the APIC in addition to the FQDN of the Linux server hosting the `Proxy Agent`
    * Examine the `puppetserver-access.log` and `puppetserver.log` on `Puppet Server` (default location: /var/log/puppetlabs/puppetserver)
    * Ensure the Puppet manifest on `Puppet Server` contains an entry for the APIC node.

##### Failures during compilation of Puppet Manifest
    When the `puppet device` command is executed it starts processing the catalog for the APIC node from `Puppet Server`. During this process, the `Puppet Server` compiles the administrator created Puppet manifest. If there are failures during the compilation, Puppet will generate appropriate error messages. When `puppet device` runs in background it will be difficult to see the messages, unless a Puppet reporting tool is used. Here is a quick tip:
      * Run `puppet device` manually on the Linux server acting as the `Proxy Agent` (`puppet device --debug --trace`). Examine the outputs on the console and on the `Puppet Server`
      * Use Puppet Notice and Notify tools add debugging hooks in the manifest

##### Failures during the Fact from APIC
    Before processing the user intent from catalog, it will fetch Puppet Facts from APIC. When Puppet requests facts from APIC, it uses service provided by the `cisco_aci` module. To interact with the APIC, `cisco_aci` module performs authentication using the username and password specified in the `device.conf`. If the manual execution of `puppet device` command generates error messages related to authentication, following aspects should be examined.
      * Network connectivity between the Liux server and APIC
      * username and password specified in the `device.conf`. If the optional tkishel-puppet_device  module is used to create the configuration file, verify the Puppet manifest. If a manually created `device.conf` is used, ensure that the URL specified is correct.
      * Check log message on APIC

#### (3) Issues during the usage of the `cisco_aci` module
When `puppet device` starts processing catalog it uses `cisco_aci` module to provision APIC. This operation can fail because of syntactic or semantic errors in the resource specification the Puppet manifest. Few tips to isolate such issues are presented below.
  * Execute `puppet device --debug --trace` to obtain the error messages.
    * Look for syntactic errors in the Puppet manifest
    * Examine the Type documentation to ensure that required namevars and properties
    * Ensure that each resources provides keys (namevars) for the instance and its parents types. Type documentation clearly identifies the instance identifiers along with namevars that take the identity of the parent types. Demo manifest provides examples configuration for each supported types.
    * Ensure that the manifest uses the typical Puppet chaining approach to declare dependency between the types. Refer to sample manifests and dependency tree in the documentation directory.
    * Ensure that each properties associated with each type are providing proper values. The documentation associated with properties in a Puppet Type contains a URL. This URL points to the corresponding APIC Managed object, which explicitly states the value type and range associated with the property.

##### Enabling Debugging
  * To enable debugging at the `Puppet Agent` or `puppet device` level pass in the `--debug` flag to the respective commands. This flag will generate a lot of debug level message on the stdout. If `--trace` flag is added to aforementioned debug flag, debug output will contain code trace that can help developers isolate issues quicker. For additional details refer to the appropriate documentation from Puppet Labs.

  ```bash
  #Enable debug and trace for puppet agent
  puppet agent --debug --trace
  #Enable debug and trace for puppet device
  puppet device --debug --trace
  ```

  Debug output from the `puppet device` command execution will be displayed to the console window. The `debug` option in the device.conf is optional and generates additional debugging output related to the HTTP requests. For additional details on the `puppet device` command, refer to the [puppet documentation](https://puppet.com/docs/puppet/5.5/man/device.html) .

  * If there is a need to debug the issue at a deeper level, another debug option can be enabled to dump the HTTP message exchange between the `puppet device` and APIC. To enable this message level debugging, set the `debug` option in the `device.conf` file. The change can be enabled by (i) manually editing the `device.conf` file on the Linux server serving as the `Proxy Agent` or (ii) specifying the debug option using tkishel-puppet_device module on the `Puppet Server`.

    * Manually edit device.conf to enable HTTP packet level debug
    ```bash
    # Manually adding the debug option to the device.conf on the Linux server acting as the Proxy Agent
    # If the administrator used the tkishel- puppet_device the file will be located in the /etc/puppetlabs/puppet directory
    [apic.example.com]
    type apic
    url https://username:password@apic.example.com/
    debug
    ```
    * Use Puppet Manifest to enable HTTP packet level debug
    ```puppet
    # This option requires administrator to execute `puppet agent -t` on the Linux server serving as the proxy agent
    node 'proxy-agent.example.com' {
      puppet_device {'apic.example.com':
        #... Existing configuration
        debug            => True,  #Enabled # DEBUG:     
      }
    }
    ```

##### Manual Execution of `puppet device`
    In a typical deployment scenario, the `puppet device` command will be scheduled to run periodically on the proxy agent. To diagnose issues with the module, administrators can manually execute the `puppet device` command on the proxy agent against a locally available `device.conf` with debugging enabled.

    ```bash
    # Example: device.conf
    [apic.example.com]
    type apic
    url https://username:password@apic.example.com/
    debug
    ```

    ```bash
    puppet device --debug --trace --verbose --deviceconfig ./device.conf
    ```

##### Examine Debugging Messages
The first step to diagnose issues with the module is to examine the log messages generated during the agent execution. The log messages generated by the `cisco_aci` module can be retrieved from the typical location (#https://puppet.com/docs/puppet/5.5/services_agent_unix.html#logging-for-puppet-agent-on-nix-systems). For administrator convenience, this module generates a Puppet Notice message each time a Puppet resource is provisioned. One of the Notice messages will include the APIC URL for easy reference.

![7](docs/puppet_aci_debug_messages.png)
![8](docs/puppet_aci_debug_messages_http.png)

#### Examine Exceptions from APIC
When the `cisco_aci` module encounters error responses from the APIC, it generates two types of exceptions (with detailed error codes): ApicAuthenticationError and ApicErrorResponse.

The first exception is related to authentication issues between the `puppet device` and the APIC. When you encounter this exception, ensure that user credentials provided in the manifest (which configures `device.conf`) are valid.

The second exception is generated when the APIC encounters errors while processing the provisioning request. Commonly these types of errors result from specifying incorrect values in the Puppet Manifest. Verify the manifest to ensure that (i) parent Puppet Types are already configured, and (ii) property values specified for a Puppet Type are correct. For details on property value constraints, refer to the corresponding [MO documentation](https://developer.cisco.com/site/apic-mim-ref-api/)

#### (4) APIC Issues
  The `cisco_aci` module transforms user intent from Puppet's DSL to REST API exposed by the APIC. For troubleshooting issues with the APIC refer to the [APIC Troubleshooting Guide](https://www.cisco.com/c/en/us/td/docs/switches/datacenter/aci/apic/sw/1-x/troubleshooting/b_APIC_Troubleshooting/b_APIC_Troubleshooting_chapter_010.html).


## Limitations

This Puppet Module requires a `Puppet Agent` version `5.5` or later. A `Puppet Server` version `5.3` or later is recommended. This module has been tested with APIC running 3.3.1
