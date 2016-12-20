IIA Index endpoint
===================

* [What is the status of this document?][statuses]
* [See the index of all other EWP Specifications][develhub]


Summary
-------

This endpoint allows clients to see the list of all agreements (IIAs) known to
a particular HEI.


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

Identifier of the HEI which we want to fetch the IIA from.

This parameter is required, because one EWP Host may cover multiple HEIs, and
IIA IDs are *not* universally unique by themselves.


Permissions
-----------

All requests from the EWP Network MUST be allowed access to this API. Consult
the [Echo API][echo] specs for details on handling unprivileged requests.

Note, that this does not imply that you should return all IIA IDs. On the
contrary, you should return only such IDs which the requester has access to.


Handling of invalid parameters
------------------------------

 * General [error handling rules][error-handling] apply.

 * Invalid `hei_id` values (i.e. references to HEIs which are not covered by
   this host) MUST result in a HTTP 400 error.


Response
--------

Servers MUST respond with a valid XML document described by the
[index-response.xsd](index-response.xsd) schema. See the schema annotations
for further information.


[develhub]: http://developers.erasmuswithoutpaper.eu/
[statuses]: https://github.com/erasmus-without-paper/ewp-specs-management#statuses
[registry-spec]: https://github.com/erasmus-without-paper/ewp-specs-api-registry
[discovery-api]: https://github.com/erasmus-without-paper/ewp-specs-api-discovery
[echo]: https://github.com/erasmus-without-paper/ewp-specs-api-echo
[error-handling]: https://github.com/erasmus-without-paper/ewp-specs-architecture#error-handling
[institutions-api]: https://github.com/erasmus-without-paper/ewp-specs-api-institutions
