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


### `hei_id` (required)

Identifier of the HEI to fetch the IIA from. (This HEI also needs to be one of
the IIA's partners.)

This parameter is required, because one EWP Host may cover multiple HEIs, and
IIA IDs are *not* universally unique by themselves. Also note, that it is
theoretically possible for one EWP Host (covering multiple HEIs) to serve two
conflicting copies of a single IIA (as, per spec, each HEI can have a copy of
its own).


### `iia_id` or `iia_code` (repeatable, required)

A list of local IIA identifiers OR local IIA codes to be returned (no more than
`<max-iia-ids>` or `<max-iia-codes>` items, respectively). The requester MUST
provide either a list of `iia_id` values, or a list of `iia_code` values, **but
not both**.

HEI identified by the `hei_id` parameter MUST be one of the partners of all the
referenced IIAs (otherwise, IIA won't be found).

This parameter is *repeatable*, so the request MAY contain multiple occurrences
of it. The server is REQUIRED to process all of them.

Server implementers provide their own chosen values of `<max-iia-ids>` and
`<max-iia-codes>` via their manifest entry (see
[manifest-entry.xsd](manifest-entry.xsd)). Clients SHOULD parse these values
(or assume they're equal to `1`).


### `send_pdf` (optional)

Boolean, default false. Value `false` means, that the client is not interested
in receiving PDF version of the agreement and the PDF SHOULD be skipped in the response.

Note: the PDF version can be missing in the response even if value `true` is passed.
Some servers MAY not support PDFs at all or the PDF version can be not ready yet.
This parameter only helps to avoid unnecessary network traffic. 


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

* If you decide to *change* the visibility of an already existing IIA, and you
  implement the IIA CNR API, then you SHOULD inform all affected parties about
  such change.


Handling of invalid parameters
------------------------------

 * General [error handling rules][error-handling] apply.

 * Invalid `hei_id` values (i.e. references to HEIs which are not covered by
   this host) MUST result in a HTTP 400 error.

 * Invalid (or unknown) `iia_id` and `iia_code` values MUST be **ignored**.
   Servers MUST return a valid (HTTP 200) XML response in such cases, but the
   response will simply not contain any information on these missing entities.
   If all values are unknown, servers MUST respond with an empty `<response>`
   element. This requirement is true even when both `<max-iia-ids>` and
   `<max-iia-codes>` are set to `1`.

 * If the length of `iia_id` list is greater than `<max-iia-ids>` (or the
   length of `iia_code` list is greater than `<max-iia-codes>`), then the
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
