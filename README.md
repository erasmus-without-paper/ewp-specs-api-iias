Interinstitutional Agreements API
=================================

* [What is the status of this document?][statuses]
* [See the index of all other EWP Specifications][develhub]


Summary
-------

This document describes the **Interinstitutional Agreements API**. This API
allows partners to compare their copies of interinstitutional Erasmus+ mobility
agreements with each other, which makes it easier to spot errors.


Introduction
------------

As part of the EWP project, we have
[thoroughly discussed](https://github.com/erasmus-without-paper/general-issues/issues/12)
[many options](https://github.com/erasmus-without-paper/general-issues/issues/12#issuecomment-229931282)
of how to design the functionality of synchronizing IIAs between different
HEIs. We have proposed multiple solutions, and then rejected them, either
because of their limited functionality, or their complexity.

This document describes the solution we ended up agreeing to.


### It is not (!) required in EWP mobility flow

The most important feature to understand about this solution, is that HEIs are
not required to neither *serve* nor *use* this API.

This API is *not* part of the primary mobility flow modeled in EWP. You can
still exchange information on Nominations and Learning Agreements **without**
implementing this API. It serves *only* as a helper API to spot differences
between IIAs. If you choose to implement it, then **you should probably
implement it after all the other APIs**.

 * **Why not required?** IIA is an official document. Therefore, it seems
   reasonable to assume that:

   - Each of the partners possesses a *printed copy* of this document.
   - Their computer systems are somewhat aware of the data contained within.
   - This data is **usually** correct (in sync with the partner's copy).

   Other EWP APIs will refer to IIA **IDs** (and **IDs only**). This means
   that, although all partners might need to exchange these IDs, they still are
   allowed to simply assume that their own local copy of this IIA is correct
   (and it **usually** is).

 * **Why would I want to implement it then?** Because we can do better than
   "usually" (see the sentences above). If we expose our agreements to the
   other partner via an API, then the partner will be able to compare the
   contents more easily, and possibly **find differences** in an automated way.
   In the future, when new agreements are forged, it might also enable the
   partner to copy the agreement's data directly from one computer system to
   another, without the need of typing it by hand.


### Other features

 * **It is distributed**. Agreements (IIAs) are stored and hosted **only** by
   the institutions involved in these agreements. No agreements are stored on
   central servers at any time.

 * **All partners are equal**. There is no "master" of the agreement. Since all
   partners of a single IIA are allowed to serve their copies of this IIA,
   therefore *multiple conflicting copies of a single IIA may exist in the
   network*. These conflicts are not resolved by the system itself, but our
   APIs allow partners to discover such conflicts early (so that they may fix
   them by themselves).

 * **No history of changes.** This API will serve only a single copy of the
   agreement (with no history of previous versions). This copy should be the
   copy which is **currently in use** by the HEI which is serving the API.


### Where are the fact sheets?

If you compare our IIA XSDs to EUC IIA templates, you may notice that many
fields seem to be missing in our XSDs. This is because we have decided to
include many fields in the [Institutions API][institutions-api] instead.

We *tried* to follow the following rules:

 * We were aiming for IIAs API to describe only such data, which "belongs to"
   (and is often stored by) *all* IIA partners, whereas Institutions API and
   Organizational Units API describe data which "belongs to" a *single* partner
   only (and other partners often don't really need to store it).

 * Data which is public, and can be changed without signing the IIA again, has
   been made part of the Institutions API (and - in some cases - Organizational
   Units API). Data which is not necessarily public, and which can be changed
   only after the IIA is signed again, has been made part of the IIAs API.

As you can see, these are NOT very strict nor explicit rules. And also, we did
not necessarily follow them to the letter. As a result, sometimes it might not
be obvious where a particular piece of data can be found, but - once you get
to know the model - all should gradually become clear.


Security
--------

This version of this API uses [standard EWP Authentication and Security,
Version 2][sec-v2]. Server implementers choose which security methods they
support by declaring them in their Manifest API entry.


Endpoints to be implemented
---------------------------

Server implementers MUST:

 * Implement the [`get` endpoint](endpoints/get.md).
 * Implement the [`index` endpoint](endpoints/index.md).
 * Put the URLs of these endpoints in their [manifest file][discovery-api], as
   described in [manifest-entry.xsd](manifest-entry.xsd).

The details on each of these endpoints are described on separate pages of this
API specification (use the links above).


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
[echo]: https://github.com/erasmus-without-paper/ewp-specs-api-echo
[error-handling]: https://github.com/erasmus-without-paper/ewp-specs-architecture#error-handling
[institutions-api]: https://github.com/erasmus-without-paper/ewp-specs-api-institutions
[sec-v2]: https://github.com/erasmus-without-paper/ewp-specs-sec-intro/tree/stable-v2
