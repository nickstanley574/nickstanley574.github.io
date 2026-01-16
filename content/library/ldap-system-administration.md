---
year_read: 2020
layout: default
build:
  list: false
---

# LDAP System Administration

By Gerald Carter

ISBN: 1-56592-491-6

## Chapter 1. "Now where did I put that...?", or "What is a directory?"

While directory services can take on many different forms, the following five characteristics hold true (at a minimum):

* A directory service is highly optimized for reads.
* A directory service implements a distributed model for storing information.
* A directory service can extend the types of information it stores.
* A directory service has advanced search capabilities.
* A directory service has loosely consistent replication among directory servers.

### 1.1 The Lightweight Directory Access Protocol

By organizing your information well and thinking carefully about the common information needed by client applications, you can reduce data redundancy in your directories and therefore reduce the administrative overhead needed to maintain that data.

### 1.2 What Is LDAP?

#### **L**ightweight

Why is LDAP considered lightweight? Lightweight compared to what? (As we look at LDAP in more detail, you'll certainly be asking how something this complex could ever be considered lightweight.) LDAP is lightweight in comparison to the X.500 directory service.

#### **D**irectory

Directory services and databases share a number of important characteristics, such as fast searches and an extendable schema. They differ in that a directory is designed to be read much more than it is written; in contrast, a database assumes that read and write operations occur with roughly the same frequency.

Remember that LDAP is just a protocol; we'll discuss what that means shortly, but essentially, it's a set of messages for accessing certain kinds of data. The protocol doesn't say anything about where the data is stored. A software vendor implementing an LDAP server is free to use whatever backend it desires, ranging from flat text files on one extreme to highly scalable, indexed relational databases on the other.

#### **A**ccess **P**rotocol

Think of LDAP as the message-based, client/server protocol defined in RFC 2251. LDAP is asynchronous (although many development kits provide both blocking and non blocking APIs), meaning that a client may issue multiple requests and that responses to those requests may arrive in an order different from that in which they were issued.

### 1.3 LDAP Models

#### Information model

The information model provides the structures and data types necessary for building an LDAP directory tree.An entry is the basic unit in an LDAP directory.

You can visualize an entry as either an interior or exterior node in the **Directory Information Tree (DIT)**.

In entry contains information about an instance of one or more `objectClasses`. These `objectClasses` have certain required or optional attributes.

#### Naming model

The naming model defines how entries and data in the DIT are uniquely referenced. Each entry has an attribute that is unique among all siblings of a single parent. This unique attribute is called the relative distinguished name (RDN).

This string created by combining RDNs to form a unique name is called the node's distinguished name (DN)

#### Functional model

The functional model is the LDAP protocol itself.

#### Security model

The security model provides a mechanism for clients to prove their identity (authentication) and for the server to control an authenticated client's access to data (authorization).

## Chapter 2. LDAPv3 Overview

### 2.1 LDIF

Most system administrators prefer to use plain-text files for server configuration information, as opposed to some binary store of bits.

The **LD**AP **I**nterchange **F**ormat (LDIF), defined in RFC 2849, is a standard text file format for storing LDAP configuration information and directory contents. In its most basic form, an LDIF file is:

* A collection of entries separated from each other by blank lines
* A mapping of attribute names to values
* A collection of directives that instruct the parser how to process the information

LDIF files are often used to import new data into your directory or make changes to existing data. The data in theLDIF file must obey the schema rules of your LDAP directory.

Think of the schema as a data definition for your directory. 

```
# LDIF listing for the entry
dn: dc=plainjoe,dc=org
objectClass: domain
dc: plainjoe
```

basis LDIF syntax:
* Comments in an LDIF file begin with a pound character `#`
* Attributes are listed on the left hand side of the colon `:`, and values are presented on the right hand side. **The colon character is separated from the value by a space.**
* The `dn` attribute uniquely identifies the distinguished name (DN) of the entry.

#### 2.1.1 Distinguished Names and Relative Distinguished Names

It is important to realize that the full DN of an entry does not actually need to be stored as an attribute within that entry.

The DN is like the absolute path between the root of a filesystem and a file, a relative distinguished name (RDN)is like a filename. This is also similar a relational database system in which two or more fields can be used in combination to generate a unique index key.

Suppose that there are two employees named Jane Smith in your company: one in the Sales Department and one in the Engineering Department. Now suppose the entries for these employees have a common parent. Neither the common name (`cn`) nor the organizational unit (`ou`) attribute is unique in its own right. However, both can be used in combination to generate a unique RDN. This would look like:

```
# Example of two entries with a multivalued RDN
dn: cn=Jane Smith+ou=Sales,dc=plainjoe,dc=org
cn: Jane Smith
ou: Sales
<...remainder of entry deleted...>

dn: cn=Jane Smith+ou=Engineering,dc=plainjoe,dc=org
cn: Jane Smith
ou: Engineering
<...remainder of entry deleted...>
```

In the multivalued RDN, the plus character `+` separates the two attribute values used to form the RDN.

To prevent the `+` character from being interpreted as a special character, we need to escape it using a backslash `\`. The other special characters that require a backslash-escape if used within an attribute value are:
* A space or pound `#` character occurring at the beginning of the string.
* A space occurring at the end of the string
* `,`,`"`,`\`,`<`,`>`,`;`

 RFC 2253 defines a method of unambiguously representing a DN using a UTF-8 string representation. This normalization process boils down to:
 * Removing all nonescaped whitespace surrounding the equal sign (=) in each RDN
 * Making sure the appropriate characters are escaped
 * Removing all nonescaped spaces surrounding the multi-value RDN join character (+)
 * Removing all nonescaped trailing spaces on RDNs

the normalized version of:
`cn=gerald carter + ou=sales,  dc=plainjoe ,dc=org`
would be:
`cn=gerald carter+ou=sales,dc=plainjoe,dc=org`

The string representation of a distinguished name is normally case-preserving, and the logic used to determine if two DNs are equal is usually a case-insensitive match.
Therefore:
`cn=Gerald Carter,ou=People,dc=plainjoe,dc=org`
would be equivalent to:
`cn=gerald carter,ou=people,dc=plainjoe,dc=org`

### 2.2 What Is an Attribute?

Attribute types and the associated syntax rules are similar to variable and data type declarations found in many programming languages. The comparison is not that big of a stretch. Attributes are used to hold values. Variables in programs perform a similar task—they store information.

Unlike variables, LDAP attributes can be multivalued. Most procedural programming languages "store and replace" semantics of variable assignment. When you assign a new value to a variable, its old value is replaced.

This isn't true for LDAP; assigning a new value to an attribute adds the value to the list of values the attribute already has.

```
# LDIF listing for dn: ou=devices,dc=plainjoe,dc=org
dn: ou=devices,dc=plainjoe,dc=org
objectclass: organizationalUnit
ou: devices
telephoneNumber: +1 256 555-5446
telephoneNumber: +1 256 555-5447
description: Container for all network enabled
 devices existing within the plainjoe.org domain
```
> Note that the description attribute spans two lines. Line continuation in LDIF is implemented by leaving exactly one space at the beginning of a line. LDIF does not require a backslash `\` to continue one line to the next.

The LDIF file lists two values for the telephoneNumber attribute. In real life, it's common for an entity to be reachable via two or more phone numbers.

Some attributes can contain only a single value at any given time. Whether an attribute is single- or multivalued depends on the attribute's definition in the server's schema.

Examples of single-valued attributes include an entry's country (c), displayable name (displayName), ora user's Unix numeric ID (uidNumber).

#### 2.2.1 Attribute Syntax

Attribute type definitions include matching rules that tell an LDAP server how to make comparisons.

#### 2.2.2 What Does the Value of the objectClass Attribute Mean?

All entries in an LDAP directory must have an objectClass attribute, and this attribute must have at least one value. Each objectClass value acts as a template for the data to be stored in an entry. It defines a set of attributes that must be present in the entry and a set of optional attributes that may or may not be present.

```
# LDIF listing for dn: ou=devices,dc=plainjoe,dc=org
dn: ou=devices,dc=plainjoe,dc=org
objectclass: organizationalUnit
ou: devices
telephoneNumber: +1 256 555-5446
telephoneNumber: +1 256 555-5447
description: Container for all network enabled
 devices existing within the plainjoe.org domain
```
The entry's objectClass is an organizationalUnit.

Here's how to understand an objectClass definition:
* An objectClass possesses an OID, just like attribute types, encoding syntaxes, and matching rules.
* The keyword `MUST` denotes a set of attributes that must be present in any instance of this object.
* The keyword `MAY` defines a set of attributes whose presence is optional in an instance of the object.
* The keyword `SUP` specifies the parent object from which this object was derived.
  * A derived object possesses all the attribute type requirements of its parent.
  * Attributes can be derived from other attributes as well,inheriting the syntax of its parent as well as matching rules, although the latter can be locally overridden by the new attribute.
  * LDAP objects do not support multiple inheritance; they have a single parent object, like Java objects.
* It is possible for two object classes to have common attribute members. Because the attribute type namespace is flat for an entire schema, the `telephoneNumber` attribute belonging to an `organizationalUnit` is the same attribute type as the `telephoneNumber` belonging to some other `objectclass`, such as a `person`.

##### Object Class Types

Structural object classes - Represent a real-world object, such as a person or an organizationalUnit. Each entry within an LDAP directory must have exactly one structural object class listed in the objectClass attribute. **According to the LDAP data model, once an entry's structural objectclass has been instantiated, it cannot be changed without deleting and re-adding the entire entry.**

Auxiliary object classes - Add certain characteristics to a structural class. These classes cannot be used on their own, but only to supplement an existing structural object. There is a special auxiliary object class referred to in RFC 2252 named extensibleObject, which an LDAP server may support.

Abstract object classes - Act the same as their counterparts in object-oriented programming. These classes cannot be used directly, but only as ancestors of derived classes. The most common abstract class relating to LDAP (and X.500) that you will use is the top object class, which is the parent or ancestor of all LDAP object classes.

### 2.3 What Is the dc Attribute?

```
# LDIF listing for the entry
dn: dc=plainjoe,dc=org
dn: dc=plainjoe,dc=org
objectclass: domain
dc: plainjoe
```

Because DNS domain names are guaranteed to be unique across the Internet and canbe located easily, mapping an organization's domain name to an LDAP DN provides a simple way of determining the base suffix served by a directory and ensures that the naming context will be globally unique.

To support a mapping between a DNS domain name and an LDAP directory namespace, RFC 2247 defines two objects for storing domain components.
* The `dcObject` is an auxiliary class to augment an existing entry containing organizational information (e.g., an `organizationalUnit`).
* The `domainobject` class acts as a standalone container for both the organizational information and the domain name component (i.e., the `dc` attribute). The `organizationalUnit` and `domain` objects have many common attributes.

#### 2.3.1 Where Is dc=org?

If the directory's root entry was dc=org, with a child entry of dc=plainjoe,dc=org, then the naming context would have been `dc=org`. Our server would then unnecessarily respond to queries for any entry whose DN ended with `dc=org`, even though it only has knowledge of entries underneath `dc=plainjoe,dc=org`.

In this respect, designing an LDAP namespace is similar to designing a DNS hierarchy. Domain name servers for plainjoe.org have no need to service requests for the .org domain. These requests should be referred to the server that actually contains information about the requested hosts.

### 2.4 Schema References

"What do all of theseabbreviations mean?" There is no single source of information describing all possible LDAPv3 attribute types and object classes, but there are a handful of online sites that can be consulted to cover the most common schema items.

### 2.5 Authentication

```
dn: cn=gerald carter,ou=people,dc=plainjoe,dc=org
objectClass: person
cn: gerald carter
sn: carter
telephoneNumber: 555-1234
userPassword: {MD5}Xr4ilOzQ4PCOq3aQ0qbuaQ==
```

We have added an attribute named userPassword. This attribute stores a representation of the credentials necessary to authenticate a user. The prefix describes how the credentials are encoded.

**The act of being authenticated by an LDAP directory is called binding.** Most users are accustomed to providing ausername and password pair when logging onto a system.

#### Anonymous Authentication
Anonymous Authentication is the process of binding to the directory using an empty DN and password.

#### Simple Authentication
For Simple Authentication, **the login name in the form of a DN is sent with a password in clear text to the LDAP server.** The server then attempts to match this password with the userPassword value, or with some other predefined attribute that is contained in the entry for the specified DN. If the password is stored in a hashed format, the server must generate the hash of the transmitted password and compare it to the stored version.However, the original password has been transmitted over the network in the clear. If both passwords (or password hashes) match, the client is successfully authenticated. **While this authentication method is supported by virtually all existing LDAP servers (including LDAPv2 servers), its major drawback is its dependency on the client transmitting clear-text values across the network.**

#### Simple Authentication Over SSL/TLS
LDAP can negotiate an encrypted transport layer prior to performing any bind operations. Thus, all user information is kept secure (as well as anything else transmitted during the session).
* LDAP over SSL (LDAPS - tcp/636) is well supported by many LDAP servers, both commercial and opensource. Although frequently used, it has been deprecated in favor of the StartTLS LDAP extended operation.
* RFC 2830 introduced an LDAPv3 extended operation for negotiating TLS over the standard tcp/389 port. This operation, which is known as StartTLS, allows a server to support both encrypted and non encrypted sessions on the same port, depending on the clients' requests.

#### Simple Authentication and Security Layer (SASL)

SASL supports a pluggable authentication scheme by allowing a client and server to negotiate the authentication mechanism prior to the transmission of any user credentials.

RFC 2222 defines the several authentication schemes for SASL, including: 
* Kerberos v4 (KERBEROS_V4)
* The Generic Security Service Application Program Interface, Version 2 (GSSAPI)
* The S/Key mechanism (SKEY), which is a one-time password scheme based on the MD5 message digest algorithm.
* The External (EXTERNAL) mechanism, which allows an application to make use of a user's credentials provided by a lower protocol layer, such as authentication provided by SSL/TLS.

During the binding process, the client asks the server to authenticate its request using a particular SASL plug-in.The client and server then perform any extra steps necessary to validate the user's credentials. Once a success or failure condition has been reached, the server returns a response to the client's bind request as usual, and LDAP communication continues normally. 

### 2.6 Distributed Directories

In a distributed directory, different hosts possess different portions of the directory tree.

There are many reasons for distributing the directory tree across multiple hosts. Including but not limited too Performance, Geographic location, and Administrative boundaries.

The `referral` object contains only a single required attribute, `ref`. This attribute holds the URI that points to the host that contains the subtree.
The most common URI used as a ref value looks like:`ldap://[host:port]/dn`

For example, the LDIF listing for the new `peopleou` entry is:
```
# LDIF listing for the entry ou=people,dc=plainjoe,dc=org
dn: ou=people,dc=plainjoe,dc=orgobject
Class: referral
ref: ldap://server2.plainjoe.org/ou=people,dc=plainjoe,dc=org
```
Configuring the superior knowledge reference link, also called simply a referral but not to be confused with the referral object class, from the second server back to the main directory is a vendor-dependent operation, so it is difficult to tell you exactly what to expect.

## Chapter 3. OpenLDAP

Why are we using the OpenLDAP  server instead of one from another vendor like: Sun Microsystem's SunOne directory server, Novell's eDirectory , and Microsoft's Active Directory (although MSAD directory encompasses much more than just LDAP.)

OpenLDAP is attractive for several reasons:
* The OpenLDAP source code is available for download from http://www.openldap.org/ under the OpenLDAPPublic License.
* OpenLDAP is available for multiple platforms, including Linux, Solaris, Mac OS 10.2, and Windows (in its various incarnations)
* The OpenLDAP project is a continuation of the original University of Michigan LDAP server.

### 3.1 Obtaining the OpenLDAP Distribution

The OpenLDAP project does not make binary distributions of its software available. The reason for this has a lot todo with the number of dependencies it has on other packages. Many Linux vendors include precompiled versions ofOpenLDAP with their distributions.

There are several advantages of LDAPv3 over the previous version, such as:
* The ability to refer clients to other LDAP servers for information. The LDAPv2 RFCs contained no provision for returning a referral to a client.
* The ability to publish the server's schema via LDAP operations, which makes it easier for clients to learn the server's schema before performing searches. The only way to determine the schema supported by anLDAPv2 server was to examine the server's configuration files.
* Improved security and flexibility for authentication credentials and data via SASL and SSL/TLS. LDAPv2supported only simple binds.

The OpenLDAP 2 release is an LDAPv3 server. However, LDAPv2 clients are not going away anytime soon.Therefore, OpenLDAP 2 and the majority of other LDAP servers can support both LDAPv2 and v3 clients.

### 3.2 Software Requirements

* Support for POSIX threads, either by the operating system or an external library.
* SSL/TLS libraries (such as the OpenSSL package, which is available from http://www.openssl.org/).
* A database manager library that supports DBM type storage facilities. The current library of choice is theBerkeley DB 4.1 package from Sleepycat Software (http://www.sleepycat.com/)
* Release 2.1 of the SASL libraries from Carnegie Mellon University (http://asg.web.cmu.edu/sasl/sasl-library.html)

### 3.4 OpenLDAP Clients and Servers

Installed components included with OpenLDAP:

* The LDAP server: `libexec/slapd`
* The LDAP replication helper: `libexec/slurpd`
* Command-line tools for adding, modifying, and deleting entries on an LDAP server:
  * `bin/ldapadd`
  * `bin/ldapmodify`
  * `bin/ldapdelete`
  * `bin/ldapmodrdn`
* Command-line utilities for searching for an LDAP directory or testing a compare operation on a specific attribute held by an entry.
  * `bin/ldapsearch`
  * `bin/ldapcompare`
* A tool for changing the password attribute in LDAP entries: `bin/ldappasswd`
* Tools for manipulating the local backend data store used by the `slapd` daemon.
  * `sbin/slapadd`
  * `sbin/slapcat`
  * `sbin/slapindex`
* A simple utility to generate password hashes suitable for use in slapd.conf: `sbin/slappasswd`

### 3.5 The slapd.conf Configuration File

The `slapd.conf` file is the central source of configuration information for the OpenLDAP standalone server (`slapd`),the replication helper daemon (`slurpd`), and related tools, such as `slapcat` and `slapadd`.

As a general rule, the OpenLDAP client tools such as `ldapmodify` and `ldapsearch` use `ldap.conf` (not `slapd.conf`) for default settings.

For general needs, the slapd.conf file used by OpenLDAP 2 can be broken into two sections. The first section contains parameters that affect the overall behavior of the OpenLDAP servers (for example, the level of information sent to log files). The second section is composed of parameters that relate to a particular database backend used by the slapd daemon.

🔐 For security reasons, the slapd.conf file should be readable and writable only by the user who runs the slapd daemon, which is normally the superuser. A working server's slapd.conf often contains sensitive information that should be restricted from unauthorized viewing.

#### 3.5.1 Schema Files

OpenLDAP 2 includes several popular schema files to be used at the administrator's discretion.

All the `attributeType` and `objectClass` definitions required for a bare-bones server are included in the file `core.schema`.

In the configuration file, the `include` parameter specifies schemas to be included by the server:
```
# /usr/local/etc/openldap/slapd.conf

# Global section

## Include the minimum schema required.
include     /usr/local/etc/openldap/schema/core.schema

#######################################################
## Database sections omitted
```

There are several schema files included with a default OpenLDAP 2.1 installation::
* `corba.schema` - A schema for storing Corba objects in an LDAP directory, as described in RFC 2714.
* `core.schema` - OpenLDAP's required core schema. This schema defines basic LDAPv3 attributes and objects described in RFCs 2251-2256.
* `cosine.schema` - A schema for supporting the COSINE and X.500 directory pilots. Based on RFC 1274
* `inetorgperson.schema` - The schema that defines the `inetOrgPerson` object class and its associated attributes defined in RFC 2798. This object is frequently used to store contact information for people.
* `misc.schema` - A schema that defines a small group of miscellaneous objects and attributes.

The client applications that you want to support may require you to include schema files in addition to core.schema. Make sure you are aware of dependencies between schema files. Dependencies are normally described at the beginning of the file.

#### 3.5.2 Logging

OpenLDAP logging levels

* `-1`: All logging information
* `0`: No Logging information
* `1`: Trace function calls
* `2`: Packet-handling debugging information
* `4`: Heavy trace debugging
* `8`: Connection management
* `16`: Packets sent and received
* `32`: Search filter processing
* `64`: Configuration file processing
* `128`: Access control list processing
* `256`: Statistics for connection, operations, and results
* `512`: Statistics for results returned to clients
* `1024`: Communication with shell backends
* `2048`: Print entry parsing debug information

#### 3.5.3 SASL Options

slapd.conf has three SASL-related global options. These are:
* `sasl-host hostname` is the fully qualified domain name of the host used for SASL authentication.
* `sasl-realm string` is theSASL domain used for authentication.
* `sasl-secprops properties` allows you to define various conditions that affect SASL security properties

#### 3.5.4 SSL/TLS Options

Like the SASL parameters, slapd.conf offers several options for configuring settings related to SSL and TLS. These parameters include:
* `TLSCipherSuite cipher-suite-specification`: specify which ciphers the server will accept. It also specifies a preference order for the ciphers.This should be a colon-separated list of cipher suites.
* `TLSCertificateFile filename` and `TLSCertificateKeyFile filename`: inform `slapd` of the location of the server's certificate and the associated private key. This will be used to implement both LDAP over SSL (LDAPS) and the StartTLS extended operation.

Here are the TLS configuration parameters in the context of slapd.conf:
```
# /usr/local/etc/openldap/slapd.conf

# Global section

## Include the minimum schema required.

include     /usr/local/etc/openldap/schema/core.schema

## Added logging parameters

loglevel     296
pidfile      /usr/local/var/slapd.pid
argsfile     /usr/local/var/slapd.args

## TLS options for slapd
TLSCipherSuite          HIGH
TLSCertificateFile      /etc/local/slapd-cert.pem
TLSCertificateKeyFile   /etc/local/slapd-key.pem

#########################################################
Database sections omitted
```

#### 3.5.5 More Security-Related Parameters

`security` - parameter allows us to specify general security strength factors. To take full advantage of the security parameter, you must disable simple binds and use only SASL mechanismsfor authentication.

`require` - allows an administrator to define general conditions that must be met to provide access to the directory. Accepts a comma-separated list of the config values.

`allow` and `disallow` parameters provide another means of enabling and disabling certain features.

`password-hash` - defines the default password encryption scheme used to store values inthe `userPassword` attribute.

After covering these final parameters, you can complete the global section of your `slapd.conf`:
```
# /usr/local/etc/openldap/slapd.conf

# Global section

## Include the minimum schema required.
include     /usr/local/etc/openldap/schema/core.schema

## Added logging parameters
loglevel     296
pidfile      /usr/local/var/slapd.pid
argsfile     /usr/local/var/slapd.args

## TLS options for slapd
TLSCipherSuite          HIGH
TLSCertificateFile      /etc/local/slapd-cert.pem
TLSCertificateKeyFile   /etc/local/slapd-key.pem

## Misc security settings
password-hash     {SSHA}

#########################################################
Database sections omitted
```

#### 3.5.6 Serving Up Data

A database section begins with the `database` directive and continues until the next occurrence of the `database` directive or the end of the file. This parameter has several possible values:
* `bdb` - This backend has been specifically written to take advantage of the Berkley DB 4 database manager; it is the recommendedbackend used on an OpenLDAP server.
* `ldbm` - An ldbm database is implemented via either the GNU Database Manager or the Sleepycat Berkeley DB software package.
* `passwd` - The passwd backend is a quick and dirty means of providing a directory interface to the system passwd(5)file.

The naming context allows slapd to servemultiple, potentially disconnected partitions from a single server.The following example defines the naming context of the database tocorrespond with the local domain name, a practice recommended by RFC 2247:
```
## Define the beginning of example database.
database     bdb

## Define the root suffix you serve.
suffix          "dc=plainjoe,dc=org"
```

Each LDAP directory can have a root DN (rootdn), which is similar to the superuser account on Unix systems.

The naming of the root DN is arbitrary, although the cn values of "admin" and "Manager" have become commonchoices.

The root DN also requires a corresponding root password (`rootpw`), which can be stored in clear text orencrypted form using one of the prefixes accepted by the password-hash parameter.

🔐 OpenLDAP 2 provides the `slappasswd` utility for generating {CRYPT}, {MD5}, {SMD5}, {SSHA}, and {SHA} passwords. **Do not place the root password in plain text regardless of what the permissions on `slapd.conf` are**. Even if the password is encrypted, it is extremely important not to allow unauthorized users to view `slapd.conf`.

```
## Define a root DN for superuser privileges.
rootdn      "cn=Manager,dc=plainjoe,dc=org"

## Define the password used with rootdn. This is a salted secure hash of the phrase "secret."
rootpw          {SSHA}2aksIaicAvwc+DhCrXUFlhgWsbBJPLxy
```

You aren't required to define a root password. If no rootpw directive is present, the rootdn is authenticated usingthe server's default authentication method (e.g., SASL).

The `directory` and `mode` parameters define the physical location and filesystem permissions of the createddatabase files. These parameters are necessary because, when using an ldbm backend, slapd manages the datastore itself.

The `index` parameter specifies the attributes on which slapd should maintain indexes. These indexes are used tooptimize searches, similar to the indexes used by a relational database management system. There can be multiple index definitions for the same database—and even multiple attributes or index types—on thesame line. I cannot stress the use of proper indexes enough. Misconfigured indexes are probably the number one reasonadministrators experience performance problems with OpenLDAP servers.

The `cachesize` parameter allows you to tune caching according to the needs of the directory.  The default is to cache `1000` entries. If your total directory size is less than `1000` entries, there is no need to modify this setting. If your directory contains `1000000` entries, a cache size of `100000` would not be unusual.

```
## Define the beginning of example database.
database        bdb

## Define the root suffix you serve.
suffix          "dc=plainjoe,dc=org"

## Define a root DN for superuser privileges
.rootdn          "cn=Manager,dc=plainjoe,dc=org"

## Define the password used with rootdn. This is the Base64-encoded MD5 hash of"secret."
rootpw          {SSHA}2aksIaicAvwc+DhCrXUFlhgWsbBJPLxy

## Directory containing the database files.
directory       /var/ldap/plainjoe.org

## Files should be created rw for the owner **only**.
mode            0600

## Maintain presence and equality searches on the cn and uid attributes.
index           objectClass     eq
index          cn          pres,eq

## db tuning parameters; cache 2,000 entries in memory
cachesize       2000
```

### 3.6 Access Control Lists (ACLs)

**Who has *Access* to *What*?**

The most frequent forms of **"Who"** include:
* `*` - Matches any connected user, including anonymous connection
* `self` - The DN of the currently connected user, assuming he has been successfully authenticated by a previous bindrequest.
* `anonymous` - Nonauthenticated user connections
* `users` - Authenticated user connections
* *Regular expression* - Matches a DN or an SASL identity.

The simplest way to control access is to define a default level of authorization. A global `slapd.conf` parameter defines the default access given to a user in the absence of a more explicit rule.

Summary of access levels from most (top) to least (bottom):
* `write` - Access to update attribute values
* `read` - Access to read search results
* `search` - Access to apply search filters
* `compare` - Access to compare attributes
* `auth` - Access to bind (authenticate). This requires that the client send a username in the form of a DN andsome type of credentials to prove his or her identity.
* `none` - No access

```
## Give users search access when no other ACL applies.
defaultaccess     search
```

The **"What"** defines the entry and attributes to which the ACL should apply. It is composed of three basicparts, all of which are optional:
* A regular expression defining the DN of the proposed target of the ACL.
* An LDAP search filter that conforms to RFC 2254.
* A comma-separated list of attribute names taking the form `attrs=attributeList`. If this item is notpresent, the ACL applies to all attributes held by the entry that matches the DN regular expression pattern

The following ACL grants read access to everyone:
```
# Simple ACL granting read access to the world
access to *
    by * read
```

This next example restricts access to the `userPassword` attribute; any user can access the attribute, but can access it only for authentication purposes. Users can't read or write this attribute.

```
# Restrict userPassword to be used for authentication only.
access to attrs=userPassword
  by * auth
```

If a user should be allowed to modify her own password in the directory, the ACL would need to be rewritten as follows:
```
# Restrict userPassword to be used for authentication only, but allow users to modify
# their own passwords.
access to attrs=userPassword
  by self write
  by * auth
```

**ACLs are evaluated on a "first match wins" basis. This means that more restrictive ACLs should be listed prior to more general ones.**

```
# Restrict userPassword to be used for authentication only, but allow users to modify
# their own passwords.
access to attrs=userPassword
  by self write
  by * auth

# Simple ACL granting read access to the world
access to *
  by * read
```

## Chapter 4. OpenLDAP: Building a Company White Pages

### 4.1 A Starting Point
```
# /usr/local/etc/openldap/slapd.conf
# Global section

## Include the minimum schema required.
include       /usr/local/etc/openldap/schema/core.schema

## Added logging parameters
loglevel      296
pidfile       /usr/local/var/slapd.pid
argsfile      /usr/local/var/slapd.args

## TLS options for slapd
TLSCipherSuite             HIGH
TLSCertificateFile         /etc/local/slapd-cert.pem
TLSCertificateKeyFile      /etc/local/slapd-key.pem

## Misc security settings
password-hash         {SSHA}

#######################################################
## Define the beginning of example database.
database bdb

## Define the root suffix you serve.
suffix                "dc=plainjoe,dc=org"

## Define a root DN for superuser privileges.
rootdn                "cn=Manager,dc=plainjoe,dc=org"

## Define the password used with rootdn. This is the base64-encoded MD5 hash of
## "secret."
rootpw                {SSHA}2aksIaicAvwc+DhCrXUFlhgWsbBJPLxy

## Directory containing the database files
directory             /var/ldap/plainjoe.org

## Files should be created rw for the owner **only**.
mode                  0600

## Indexes to maintain
index                 objectClass          eq
index                 cn                   pres,eq

## db tuning parameters; cache 2,000 entries in memory
cachesize             2000

# Simple ACL granting read
access to the worldaccess to *
  by * read
```

### 4.2 Defining the Schema

The first step in implementing a directory is determining what information to store in the directory.

Information stored in anexisting Human Resources database can provide a good starting point. Of course, you may not want to place all ofthis information in your directory.

An alternative to starting with an existing database is to determine which employee attributes you wish to makeavailable and define a schema to match that list. The reverse also works: you can select a standard schema anduse the attributes already defined.

For your directory, the `inetOrgPerson` schema defined in RFC 2798 is more than adequate.

Another way to reduce the number of name collisions is to redesign the directory layout to reduce the total numberof user entries sharing a common parent. In other words, group employees in some type of logical container, suchas a departmental organizational unit.
```
                  dc=planjoe,dc=org
                  //              \\
               on=sales          on=engineering
                //                  \\
  cn=John Arbuckle                 cn=John Arbuckle
```

Here is an employee entry that contains the attributes needed for our directory
```
## LDIF entry for employee "Gerald W. Carter"
dn: cn=Gerald W. Carter,ou=people,dc=plainjoe,dc=org
objectClass: inetOrgPerson
cn: Gerald W. Carter
sn: Carter
mail: jerry@plainjoe.org
mail: gcarter@valinux.com
labeledURI: http://www.plainjoe.org/
roomNumber: 1234 Dudley Hall
departmentNumber: Engineering
telephoneNumber: 222-555-2345
pager: 222-555-6789
mobile: 222-555-1011
```

#### Deep or Wide?

Is it better to maintain a shallow (and wide) tree or a deep (and narrow) directory? The best structurefor your directory depends on two factors.

First, how likely is it for a change to force an entry (in our case, a person) to be moved from oneorganizational unit to another? The answer to this question is based on a solid understanding of yourorganization and its needs. Deeper directory trees imply that an entry must meet more requirementsin order to be placed in a certain container.

Second, does the implementation of your LDAP directory server favor one design over another? ForOpenLDAP, this answer depends on your needs. The determining factor will be the number of updates,or writes, that will be made to the directory. To update an entry, the slapd server obtains a lock onthe parent entry for the requesting client. Now suppose that you have a very shallow directory treewith 10,000 entries under a single parent. If many updates occur at the same time, the contention forthe lock on the parent entry will be very high. The end result will be slower updates because processeswill block waiting for the lock.

A deeper tree means that you can often make searches more efficient by giving a more detailedsearch base. For more information on designing LDAP namespaces, you may wish to read Howes, etal., Understanding and Deploying LDAP Directory Services (MacMillan Technical Press).

### 4.3 Updating slapd.conf

Once the schema has been selected, the next step is to modify slapd.conf to support the selected attribute typesand object classes. In order to support the inetOrgPerson object class, you must include inetorgperson.schema,core.schema, and cosine.schema in slapd.conf. The comments that begin inetorgperson.schema outline thedependency on the COSINE schema. Here are the modifications to the global section of slapd.conf:
```
# /usr/local/etc/openldap/slapd.conf

# Global section

## Include the minimum schema required.
include         /usr/local/etc/openldap/schema/core.schema

## Added to support the inetOrgPerson object.
include         /usr/local/etc/openldap/schema/cosine.schema
include         /usr/local/etc/openldap/schema/inetorgperson.schema

## Added logging parameters
...
```

To better supportsearches for employees, you should modify the set of indexes to include a more complete list of attributes.
```
## Indexes to maintain
index         objectClass         eq
index         cn,sn,mail          eq,sub
index         departmentNumber    eq
```

### 4.5 Adding the Initial Directory Entries

There are two ways to add information to your directory; which method to use depends on the directory's state.

First, `slapadd` and the other `slap*`. They allow an administrator to import entries directly into the database files and export the entire directory as an LDIF file. They work directly with the database, and don't interact with `slapd`.

Second, the OpenLDAP distribution includes a number of tools, such as `ldapmodify`, that can update a livedirectory using the LDAPv3 network operations. These tools access the directory through the server.

A good rule of thumb is that the `slap*` tools are used for getting your LDAP server online, and the `ldap*` tools are for day-to-day administration of the directory.

The `slapcat` utility dumps the contents of an entire directory (including persistent operational attributes such asmodifyTimeStamp) in LDIF format.

`slapcat` can provide a useful means of backing up thed irectory. Unlike the actual DBM datafiles, which are machine- and version-dependent, LDIF is very portable andallows easier editing in case of corrupted data. I don't mean to discourage you from backing up the DBM files, butyou could do worse than backing up the directory in both forms.

The `slapindex` command can be used to regenerate the indexes for a bdb backend. **This might be necessary if anew index was added to slapd.conf after the directory was populated with entries.**

To start populating your directory, create a file containing the LDIF entries of the top-level nodes. These LDIFentries build the root node and the people organizational unit:

```
# /tmp/top.ldif

## Build the root node.
dn: dc=plainjoe,dc=org
dc: plainjoe
objectClass: dc
ObjectobjectClass: organizationalUnit
ou: PlainJoe Dot Org

## Build the people ou.
dn: ou=people,dc=plainjoe,dc=org
ou: people
objectClass: organizationalUnit

--------------------------------------
root# slapadd -v -l /tmp/top.ldif
```

#### 4.5.1 Verifying the Directory's Contents

You can use `ldapsearch` to query the server. `ldapsearch` allows you to dig through your directory, test for the existence of data, and test whether access control has been set up correctly.

For now, focus on very simple searches that assure you the directory is up and running correctly. 

In its simplest form, a query requires the following information:
* The LDAP server's hostname or IP address
* The credentials (i.e., user DN and password) to use to bind to the host
* The search base in the form of a DN
* The scope of the directory to search
* A search filter
* A list of attributes to return

"Show me everything" search: `ldapsearch -x -b "dc=plainjoe,dc=org" "(objectclass=*)"`


#### 4.5.2 Updating What Is Already There

Te name `ldapmodify` is a little misleading; this utility can **add** new entries and **delete** or **update** existing entries using some of the advanced features of LDIF for its input language.

The following LDIF listing defines two entries that we will add to our directory:

```
# /tmp/users.ldif

## LDIF entry for "Gerald W. Carter"
dn: cn=Gerald W. Carter,ou=people,dc=plainjoe,dc=org
cn: Gerald W. Carter
sn: Carter
mail: jerry@plainjoe.org
mail: gcarter@valinux.com
labeledURI: http://www.plainjoe.org/
roomNumber: 1234 Dudley Hall
departmentNumber: Engineering
telephoneNumber: 222-555-2345
pager: 222-555-6789
mobile: 222-555-1011
objectclass: inetOrgPerson

## LDIF entry for "Jerry Carter"
dn: cn=Jerry Carter,ou=people,dc=plainjoe,dc=org
cn: Jerry Cartersn: Carter
mail: carter@nowhere.net
telephoneNumber: 555-123-1234
objectclass: inetOrgPerson
```

The following command shows how to add these entries to the directory while it is running. Because write privileges are required to add new entries, `ldapmodify` binds to the directory using the credentials from the `rootdn` and `rootpw` `slapd.conf` parameters.
```
ldapmodify -D "cn=Manager,dc=plainjoe,dc=org" -w secret -x -a -f /tmp/users.ldif
```
There are two common causes of this error message. You may have forgotten to include all the necessary schemafiles in slapd.conf, or you may have extra whitespace at the end of line in the LDIF file. 

Now let's see how a modification works. Suppose you want to add a URL to the entry for cn=JerryCarter,ou=people,dc=plainjoe,dc=org. To add a URL, use the `labeledURI` attribute. In addition, you should delete the gcarter@valinux.com email address for "Gerald W. Carter" because it hasbecome invalid.

```
## /tmp/update.ldif

## Add a web page location to Jerry Carter.
dn: cn=Jerry Carter,ou=people,dc=plainjoe,dc=org
changetype: modify
add: labeled
URIlabeledURI: http://www.plainjoe.org/~jerry/

## Remove an email address from Gerald W. Carter.
dn: cn=Gerald W. Carter,ou=people,dc=plainjoe,dc=org
changetype: modify
delete: mail
mail: gcarter@valinux.com
```

The `changetype` keyword in the LDIF file is the key to modifying existing entries. This keyword can accept thefollowing values:
* `add` - Adds the entry to the directory.
* `delete` - Deletes the entry from the directory.
* `modify` - Modifies the attributes of an entry. With this keyword, you can both add and delete attribute values.
* `modrdn` - Changes the RDN of an entry.
* `moddn` - Changes the DN of an entry.

```
ldapmodify -D "cn=Manager,dc=plainjoe,dc=org" -w secret -x -v -f /tmp/update.ldif
```

LDIF file is parsed sequentially from the top. Therefore, later LDIF entries can modify entriescreated previously in the file.

Modifying the `RDN` of an entry takes a little more thought than adding an entry or changing an attribute of anentry. **If the entry is not a leaf node, changing its `RDN` orphans the children in the directory because the `DN` of their parent has changed.** You should make sure that you don't leave orphaned nodes in the directory—you should move the nodes with their parent or give them a new parent.

With that in mind, let's think about how to changethe RDN of the entry:
```
## /tmp/modrdn.ldif

## Change the RDN from "Jerry Carter" to "Gerry Carter."
dn: cn=Jerry Carter,ou=people,dc=plainjoe,dc=org
changetype: modrdn
newrdn: cn=Gerry Carter
deleteoldrdn: 1
```

If an entire subtree of the directory needs to be moved, a better solution may be to export the subtree to an LDIF file, modify all occurrences of the changed attribute in all the DNs, and finally re-add the subtree to the newlocation. Once the information has been entered correctly into a location, you can then use a recursive ldapdeleteto remove the old subtree.

## Chapter 5. Replication, Referrals, Searching, and SASL Explained


### 5.1 More Than One Copy Is "a Good Thing"

Because LDAP replication is vendor-specific at the moment, it is not possible to replicate data from one vendor'sserver to another vendor's server.

Here are a few symptoms that indicate the need for directoryreplicas:
* If one application makes heavy use of the directory and slows down the server's response to other client applications.
* If the directory server does not have enough CPU power to handle the number of requests it is receiving,installing a replica can improve response time. You may also wish to install several read-only replicas and usesome means of load balancing, such as round-robin DNS or a virtual server software package.
* If the directory server cannot be taken offline for backups, consider implementing a read-only replica toprovide service while the master server is taken down for backups or normal maintenance.
* if your directory is a critical part of the services provided by your network, using replicas can help providefailover and redundancy.

This design uses a secondary daemon (`slurpd`) to process a change log written by the standalone LDAP server (`slapd`). `slurpd` then forwards the changes to the replica's local slapd instance using normal LDAP modifycommands. 

#### 5.1.2 Replication in a Nutshell

1. Stop the master server's slapd daemon
2. Reconfigure the master server's slapd.conf to enable replication to the new slave server.
3. Copy the database from the master server to the replica.
4. Configure the replica server's slapd.conf.
5. Start the replica server's slapd process
6. Start the master server's slapd process.
7. Start the master server's slurpd process

### 5.1.3 Configuring the Master Server

You need toadd two directives to the database section of slapd.conf.
First, you need to add the name of the log file in which slapd will record all LDAP modifications. This is specifiedusing the replogfile parameter:
```
## -- master slapd --
# Specify the location of the file to append changes to.
replogfile     /var/ldap/slapd.replog
```

The second parameter you need to add informs slurpd where to send the changes. You add this parameter,`replica`, just below the replogfile directive.

```
## -- master slapd --
# Set the hostname and bind credentials used to propagate the changes in the# replogfile.

replica     host=replica1.plainjoe.org:389
            suffix="dc=plainjoe,dc=org"
            binddn="cn=replica,dc=plainjoe,dc=org"
            credentials=MyPass
            bindmethod=simple
            tls=yes
```

`replica` specifies the host and port to which the data should be sent, the portion of the partition to be replicated,the DN to use when binding to the replicated server, **any credentials that are acquired**, and information about thebinding method and protocols.

### 5.1.4 Configuring the Replica Server

The first step in creating a replica is to initialize its database with a current copy of the directory from the masterserver.

There are two ways to accomplish this:

1. Copy the master's database files to the replica.
2. Export the master's database to an LDIF file and reimport the entries into the replica.

A more general way to transfer the master's database is to export the database to an LDIF fileusing `slapcat`.

```
root@master# slapcat -b "dc=plainjoe,dc=org" -l contents.ldif

...copy contents.ldif to the slave server...
root@replica1# slapadd -l contents.ldif
```

Once the data has been copied to the slave server, it is time to update the replica's slapd.conf to accept updatesfrom the master server. The global section of the replica's configuration file will be identical to the master server's.

The database section of the slave's slapd.conf will also be identical, minus the replication parameters and with anappropriate local `rootdn` and `rootpw`. For the purposes of this chapter, the slave's database section contains the following `rootdn` and `rootpw`.

```
## -- slave slapd --##
replica's administrative DN

rootdn     "cn=replica,dc=plainjoe,dc=org"

## Salted Secure Hash version of MyPass
rootpw     {SSHA}SMKnFPO435G+QstIzNGb4RGjT0KLz2TV

## Define the DN that will be used by the master slurpd to replicate data. Normally,
## this is the rootdn of the slave server or, at the minimum, a DN that is allowed
## write access to all entries via an ACL.
updatedn     "cn=replica,dc=plainjoe,dc=org"

## Specify the LDAP URL of the master server, which can accept update requests.
updateref     ldap://pogo.plainjoe.org
```

The last step is to launch the master and slave's slapdprocesses using the procedure described in earlier chapters.

## 5.2 Distributing the Directory

Let's assume tha, the top level of your directory server (`dc=plainjoe,dc=org`) ismaintained by one department, and the server containing host information (`ou=hosts,dc=plainjoe,dc=org`) ismanaged by another. How can these two directories be combined into one logical DIT?
```
----------------------
| dc=plainjoe,dc=org |
----------------------
                  \\
                -------------------------------
                | ou=hosts,dc=plainjoe,dc=org |
                -------------------------------
```
The definition for the ou=hosts partition held by the second server is very similar to the database section we havebeen using so far.

(Skipping for now, currenlty not needed for my purposes)

### 5.3 Advanced Searching Options

In its commonly used form, an LDAP search filter has the following syntax: `(attribute filterOperator value )`

the attribute is the actual name of the attribute type. The filterOperator is one of: `=`, `~=`, `<=`, `>=`

The value portion can be either an absolute value, such as carter or 555-1234, or a pattern using the asterisk(`*`) character as a wildcard. Here are some wildcard searches:`(telephoneNumber=555*)` Finds all telephone numbers beginning with 555.

You can combine single filters like these using the following Boolean operators: `&` AND, `|` OR, `!` NOT.

LDAP search filters use prefix notation for joining search conditions. To search for users with a surname(`sn`) of "smith" or "jones," you can build the following filter:`(|(sn=smith)(sn=jones))`

o look for people with a last name of "smith" or "jones" and a firstname beginning with "John," the search would be modified to look like: `(&(|(sn=smith)(cn=jones))(cn=john*))`

#### 5.3.1 Following Referrals with ldapsearch

By default, the ldapsearch tool shipped with OpenLDAP 2 prints information about referral objects but does notautomatically follow them. To follow the searchreferral, give the -C (chase referrals) option when you invoke ldapsearch:

#### 5.3.2 Limiting Your Searches

Searchesw ith filters such as (objectclass=*) can put quite a strain on the directory server and generate more outpu than you want to deal with.

OpenLDAP 2 slapd.conf global search limit parameters:
* `sizelimit integer` - Defines the maximum number of entries that the server will return to a client when respondingto a search request. The default value is 500 entries.
* `timelimitinteger` - Specifies the maximum number of seconds in real time to be spent when responding to asearch request. The default limit is 1 hour (3,600 seconds)

Command-line parameters for defining search limits in ldapsearch:
* `-l integer` - Specifies the number of seconds in real time to wait for a response to a search request. A value of 0removes the timelimit default in ldap.conf
* `-z integer` - Defines the maximum number of entries to be retrieved as a result of a successful search request. Avalue of 0 removes the limits set by the sizelimit option in ldap.conf.

### 5.4 Determining a Server's Capabilities

#### rootDSE
The `rootDSE` object contains information about features such as the server naming context, implemented SASL mechanisms, and supported LDAP extensions and controls.

LDAPv3 requires that the `rootDSE` has an empty DN.

To list the `rootDSE`, perform a base-level search using a DN of "". OpenLDAP will provide only values held by the `rootDSE` if the search requests that operational attributes be returned, so the `+` character is appended to the search request:
`$ ldapsearch -x -s base -b "" "(objectclass=*)" +` 

#### SubSchemaSubentry
The `SubSchemaSubentry` attribute specifies the base search suffix for querying the schema supported by theserver. This means that clients can verify that the server supports a given matching rule, attribute type, or objectclass prior to performing an operation that depends on a certain characteristic.

`$ ldapsearch -D "cn=Manager,dc=plainjoe,dc=org" -w n0pass -x -s base -b "cn=SubSchema" "(objectclass=*)" +`

### 5.5 Creating Custom Schema Files for slapd

Creating a custom schema file for OpenLDAP is a simple process:
* Assign a unique OID for all new attribute types and object classes.
* Create the schema file and include it in `slapd.conf`.

When creating new attributes or object classes, it is agood idea to use an OID that is guaranteed to be unique, whether or not the schema will ever be used outside ofyour organization. The best way to guarantee that the OID is unique is to obtain a private enterprise number andplace all your definitions under that number.

Let's call the new object `plainjoePerson`. Add the following definition to a custom schema file namedplainjoe.schema; you'll use this file for all custom objects that you define.

```
# /usr/local/etc/openldap/schema/plainjoe.schema

## objectclass definition for 'plainjoePerson' depends on core.
schema.objectclass ( 1.3.6.1.4.1.7165.1.1.1.1 NAME 'plainjoePerson'
  SUP person STRUCTURAL
  MUST (userPassword $ mail) )
```

You need to add an include line in `slapd.conf` for your new schema file:
```
# /usr/local/etc/openldap/slapd.conf

# Global section

## Include the minimum schema required.
include     /usr/local/etc/openldap/schema/core.schema

## **NEW**
## Include support for special plainjoe objects.
include     /usr/local/etc/openldap/schema/plainjoe.schema
```

### 5.6 SASL and OpenLDAP

(Skipping for now, currenlty not needed for my purposes)

## Chapter 6. Replacing NIS

(Skipping for now, currenlty not needed for my purposes)

## Chapter 7. Email and LDAP

### 7.1 Representing Users

With only a few modifications to your directory, the posixAccount and inetOrgPerson objectclasses can be used to store a single user entry for both authentication and contact information.

One final note before we begin looking at specifics of email integration: the mail attribute is optional in theinetOrgPerson schema definition. However, it's clearly mandatory when you're trying to support mail clients andservers

### 7.2 Email Clients and LDAP

Using a standard schema is vastly preferableto building your own. Of course, with email you don't have the ability to specify what client users will use: at yoursite, many different clients are probably in use, and you won't make friends by asking users to change.

(Skipping for now, currenlty not needed for my purposes)


