IIA Get endpoint
================

* [What is the status of this document?][statuses]
* [See the index of all other EWP Specifications][develhub]


Summary
-------

This endpoint allows the client to get the content of a specific IIAs (by their
IDs). If you haven't read it yet, then read
[the IIAs API introduction][iias-api] first.


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


### `iia_id` (repeatable, required)

A list of local IIA identifiers to be returned (no more than
`<max-iia-ids>` items).

This parameter is *repeatable*, so the request MAY contain multiple occurrences
of it. The server is REQUIRED to process all of them.

Server implementers provide their own chosen value of `<max-iia-ids>`
via their manifest entry (see
[manifest-entry.xsd](manifest-entry.xsd)). Clients SHOULD parse this value
(or assume it's equal to `1`).


Permissions
-----------

Server implementers may choose their own policy in regard to the visibility of
their IIAs for certain requesters. The following requirements MUST be
satisfied:

* You MUST be consistent. If you allow a specific requester to see a specific
  IIA, then this IIA MUST also be listed (to this requester) via the `index`
  endpoint. Similarly, if you leave a reference to an IIA when the requester is
  using any of the other APIs, then this requester MUST also be allowed to read
  this IIA.

* You SHOULD allow an IIA to be read at least by all its partners. This is,
  after all, what this API is for.

* If you decide to *change* the visibility of an already existing IIA,
  then you SHOULD inform all affected parties about such change.


Handling of invalid parameters
------------------------------

 * General [error handling rules][error-handling] apply.

 * Invalid (or unknown) `iia_id` values MUST be **ignored**.
   Servers MUST return a valid (HTTP 200) XML response in such cases, but the
   response will simply not contain any information on these missing entities.
   If all values are unknown, servers MUST respond with an empty `<response>`
   element. This requirement is true even when `<max-iia-ids>
   is set to `1`.

 * If the length of `iia_id` list is greater than `<max-iia-ids>`, then the
   server SHOULD respond with HTTP 400 error. Clients SHOULD split such large
   requests into a couple of smaller ones.


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
