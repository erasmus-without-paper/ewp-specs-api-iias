IIA Get endpoint
================

* [What is the status of this document?][statuses]
* [See the index of all other EWP Specifications][develhub]


Summary
-------

This endpoint allows the client to get the content of a specific IIAs (by their
IDs). If you haven't read it yet, then read [the IIAs API introduction]
[iias-api] first.


Request method
--------------

 * Requests MUST be made with either HTTP GET or HTTP POST method. Servers MUST
   support both these methods. Servers SHOULD reject all other request methods.

 * Clients are advised to use POST when passing large number of parameters
   (servers MAY set a limit on their GET query string length).


Request parameters
------------------

Parameters MUST be provided either in a query string (for GET requests), or in
the `application/x-www-form-urlencoded` format (for POST requests).


### `hei_id` (required)

Identifier of the HEI to fetch the IIA from. (This HEI also needs to be one of
the IIA's partners.)

This parameter is required, because one EWP Host may cover multiple HEIs, and
IIA IDs are *not* universally unique by themselves. Also note, that it is
theoretically possible for one EWP Host (covering multiple HEIs) to serve two
conflicting copies of a single IIA (as, per spec, each HEI can have a copy of
its own).


### `iia_id` (repeatable, required)

A list of local IIA identifiers (no more than `<max-iia-ids>` items) - IDs of
agreements the client wants to retrieve information on. HEI identified by the
`hei_id` parameter needs to be one of the partners of all the referenced IIAs
(otherwise, IIA won't be found).

This parameter is *repeatable*, so the request MAY contain multiple occurrences
of it. The server is REQUIRED to process all of them.

Server implementers provide their own chosen value of `<max-iia-ids>` via
their manifest entry (see [manifest-entry.xsd](manifest-entry.xsd)). Clients
SHOULD parse this value (or assume it's equal to `1`).


Permissions
-----------

All requests from the EWP Network MUST be allowed access to this API. Consult
the [Echo API][echo] specs for details on handling unprivileged requests.


Handling of invalid parameters
------------------------------

 * General [error handling rules][error-handling] apply.

 * Invalid `hei_id` values (i.e. references to HEIs which are not covered by
   this host) MUST result in a HTTP 400 error.

 * Invalid (unknown) `iia_id` values MUST be ignored. Servers MUST return
   a valid (HTTP 200) XML response in such cases, but the response will simply
   not contain the information on the unknown `iia_id` values. (If all values
   are unknown, servers MUST respond with an empty envelope.)

 * If the length of `iia_id` list is greater than `<max-iia-ids>`, servers
   SHOULD respond with HTTP 400 error. Clients SHOULD split such large requests
   into a couple of smaller ones.


Response
--------

Servers MUST respond with a valid XML document described by the
[get-response.xsd](get-response.xsd) schema. See the schema annotations for
further information.


[develhub]: http://developers.erasmuswithoutpaper.eu/
[statuses]: https://github.com/erasmus-without-paper/ewp-specs-management#statuses
[iias-api]: https://github.com/erasmus-without-paper/ewp-specs-api-iias
[echo]: https://github.com/erasmus-without-paper/ewp-specs-api-echo
[error-handling]: https://github.com/erasmus-without-paper/ewp-specs-architecture#error-handling
