IIA Stats endpoint
================

* [What is the status of this document?][statuses]
* [See the index of all other EWP Specifications][develhub]


Summary
-------

This endpoint allows the client to get the statistics describing IIAs from a specific HEI.

Request method
--------------

 * Requests MUST be made with either HTTP GET or HTTP POST method. Servers MUST
   support both these methods. Servers SHOULD reject all other request methods.

Request parameters
------------------

Parameters MUST be provided either in a query string (for GET requests), or in
the `application/x-www-form-urlencoded` format (for POST requests).


### `hei_id` (required)

Identifier of the HEI to gather IIAs statistics from.

Response time
-----------

Server SHOULD respond as fast as possible. This is why it is recommended to calculate statistics offline, rather than on request.
If the statistics are calculated offline, server MUST refresh them at least once a month.
It's also a reason why calculation date is included in the response.


Permissions
-----------

Server SHOULD make this endpoint public. Server MUST allow EWP-Stats portal node to access this endpoint (TODO: to be verified)


Handling of invalid parameters
------------------------------

 * General [error handling rules][error-handling] apply.

 * Invalid `hei_id` values (i.e. references to HEIs which are not covered by
   this host) MUST result in a HTTP 400 error.

Response
--------

Servers MUST respond with a valid XML document described by the
[stats-response.xsd](stats-response.xsd) schema. See the schema annotations for
further information.


[develhub]: http://developers.erasmuswithoutpaper.eu/
[statuses]: https://github.com/erasmus-without-paper/ewp-specs-management#statuses
[iias-api]: https://github.com/erasmus-without-paper/ewp-specs-api-iias
[echo]: https://github.com/erasmus-without-paper/ewp-specs-api-echo
[error-handling]: https://github.com/erasmus-without-paper/ewp-specs-architecture#error-handling
