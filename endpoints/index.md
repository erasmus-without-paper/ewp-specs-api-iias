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

Identifier of the HEI which we want to fetch the list of IIAs from.


### `receiving_academic_year_id` (optional, repeatable)

If given, then the server SHOULD limit the list of returned IIA IDs to only
such, which are valid in at least one of the given academic years.

In other words, if we are called with the following parameters:

```
hei_id=any&receiving_academic_year_id=2005/2006&receiving_academic_year_id=2006/2007
```

Then, if an agreement `A` doesn't contain at least one of these academic years
in the `<receiving-academic-year-id>` lists in any of its cooperation
conditions, then `A` SHOULD NOT be included in the response.


Permissions
-----------

All requests from the EWP Network MUST be allowed access to this API. Consult
the [Echo API][echo] specs for details on handling unprivileged requests.

Note, that this does not imply that you must return all your IIA IDs. You
SHOULD return only such IDs which the requester has access to. See the `get`
endpoint for details on which IIAs should be accessible by which requester.


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
