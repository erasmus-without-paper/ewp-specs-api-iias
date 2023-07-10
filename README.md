Interinstitutional Agreements API
=================================

* [What is the status of this document?][statuses]
* [See the index of all other EWP Specifications][develhub]


Summary
-------

This document describes the **Interinstitutional Agreements API**. This API
allows partners to compare their copies of interinstitutional Erasmus+ mobility
agreements with each other, which makes it easier to spot errors. This API is complementary
with the [Interinstitutional Agreements Approval API][iias-approval-api]
where HEIs can approve agreements they exchange via the IIAs API.


Introduction
------------

As part of the EWP project, we have
[thoroughly discussed](https://github.com/erasmus-without-paper/general-issues/issues/12)
[many options](https://github.com/erasmus-without-paper/general-issues/issues/12#issuecomment-229931282)
of how to design the functionality of synchronizing IIAs between different
HEIs. The IIAs API is the final result.


### Features

 * **It is distributed**. Agreements (IIAs) are stored and hosted **only** by
   the institutions involved in these agreements. If the institutions use the IIA Manager
   (part of the Dashboard), their agreements are stored in the Dashboard repository.

 * **All partners are equal**. There is no "master" of the agreement. Since all
   partners of a single IIA are allowed to serve their copies of this IIA,
   therefore *multiple conflicting copies of a single IIA may exist in the
   network*. These conflicts are not resolved by the system itself, but our
   APIs allow partners to discover such conflicts early (so that they may fix
   them by themselves).

 * **No history of changes.** This API will serve only a single copy of the
   agreement (with no history of previous versions). This copy should be the
   copy which is **currently in use** by the HEI which is serving the API.


### Important rules


* Electronic versions of IIAs should model their former paper equivalents in a straightforward manner.
* Two HEIs sign one or several IIAs with one or several cooperation conditions.
* Specifications support IIAs with many cooperation conditions and each node in the network must be able
  to handle such IIAs to achieve this goal.
* Both copies of the same IIA stored in both partners' systems must be presented to each other 
  as exactly one IIA having the same number of corresponding cooperation conditions.
* Partners should exchange identifiers of their copies of the IIA to match these copies respectively in their systems.
* Regardless of whether a field is mandatory in the API, if it is present in the IIA of one HEI
  it is highly recommended having it in the matched IIA of the partner HEI.
* Providers are free to implement their local solutions to best support the needs of their customers
  but under the condition that the general principle expressed in the points above is maintained.
* Termination of an IIA, which has been mutually approved, should be treated as an agreement modification if any exchanges already took place.
  Otherwise, it should be treated as termination of the whole agreement.
* To modify an IIA which has been mutually approved, HEIs SHOULD take a snapshot of the last approved version
  to be able to revert to it if they don't conclude a new approved version of the agreement.
* An IIA that has not been mutually approved can be deleted by removing it from the EWP network.
  Such IIA MUST not be present in any of the IIA endpoints and an IIA CNR MUST be sent (see [CNR client part section][cnr-client-part]).
  An IIA can be removed from the EWP network only if it is permanently deleted.
  Identifiers of the deleted objects MUST NOT be reused for new IIAs.


### Fact sheet information

If you compare our IIA XSDs to the [official IIA template](resources)
from the European Commission, for years 2021-20[29], you may notice that
many fields seem to be missing in our XSDs. This is because we have decided
to include many fields in the [Institutions API][institutions-api]
and the [Factsheet API][factsheet-api] instead.
That is why both of the mentioned APIs MUST be implemented to use this API. 

Based on the [official IIA template](resources) from the European Commission for years 2021-20[29],
we follow the following rules:

 * General information that is part of Higher Education Institutions’ profile
   and made publicly available to students is part of the [Institutions API][institutions-api]
   (and - in some cases - [Organizational Units API][ounits-api]) and the [Factsheet API][factsheet-api].
   The general information can be updated without formal approval of the partner.

 * Data on the terms of agreement that needs to be approved by both partners
   is part of this API. The approval is done in the [IIAs Approval API][iias-approval-api]. 


### Business requirements and processes


[Business requirements and processes](resources/mandatory_business_requirements_IIA.pdf) 
document clarifies the requirements for the technical solutions
developed under EWP and in the local implementation that should adequately support
the business processes related to the approval of IIAs at Higher Education Institutions.


### IIA hash calculation


As of IIA version 7 each agreement contains an `iia-hash` element that replaces the `conditions-hash` element
used in previous versions of this API.

To calculate the new hash an IIA get response XML has to be transformed using the appropriate XSLT template provided:
 * [XSLT template for IIA version 6](resources/xsltKit/transform_version_6.xsl),
 * [XSLT template for IIA version 7](resources/xsltKit/transform_version_7.xsl).

You can test these transformations using the provided [Java class](resources/xsltKit/XsltTest.java)

You may need to find the right XSLT processor for these templates to work.
For Java [Saxon-HE-9.5.1-8.jar](http://www.java2s.com/example/jar/s/download-saxonhe9518jar-file.html) processor works,
the previous versions fail. For more details please go to [XSLT kit resources](resources/xsltKit).


Security
--------

This version of this API uses [standard EWP Authentication and Security, Version 2][sec-v2].
Server implementers choose which security methods they support by declaring them
in their Manifest API entry.


Endpoints and functionality to be implemented
---------------------------------------------

Server implementers MUST:

 * Implement the [`get` endpoint](endpoints/get.md).
 * Implement the [`index` endpoint](endpoints/index.md).
 * Implement the [`stats` endpoint](endpoints/stats.md)
 * Put the URLs of these endpoints in their [manifest file][discovery-api], as
   described in [manifest-entry.xsd](manifest-entry.xsd).

The details on each of these endpoints are described on separate pages of this
API specification (use the links above).

Implementers also MUST implement a Notification Sender for Interinstitutional Agreement objects.
That means that an EWP host will *try* to deliver notifications to all Interinstitutional Agreement CNR APIs
implemented throughout the EWP Network whenever related agreement objects are updated.


Data model entities involved in the response
--------------------------------------------

 * IIA
 * IIA Partner
 * Cooperation Condition
 * Coordinator
 * Person


[develhub]: http://developers.erasmuswithoutpaper.eu/
[statuses]: https://github.com/erasmus-without-paper/ewp-specs-management#statuses
[discovery-api]: https://github.com/erasmus-without-paper/ewp-specs-api-discovery
[institutions-api]: https://github.com/erasmus-without-paper/ewp-specs-api-institutions
[sec-v2]: https://github.com/erasmus-without-paper/ewp-specs-sec-intro/tree/stable-v2
[factsheet-api]: https://github.com/erasmus-without-paper/ewp-specs-api-factsheet
[iias-approval-api]: https://github.com/erasmus-without-paper/ewp-specs-api-iias-approval
[ounits-api]: https://github.com/erasmus-without-paper/ewp-specs-api-ounits
[cnr-client-part]: https://github.com/erasmus-without-paper/ewp-specs-architecture#client-part-sending-notifications