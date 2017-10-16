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

Identifier of the HEI which we want to fetch the list of IIAs from. This MUST
be the HEI covered by the server. It MUST be required, even if the server
covers only a single HEI.


### `partner_hei_id` (optional)

If given, then the server MUST limit the list of returned IIA IDs to only those
in which `partner_hei_id` is one of the partners. This value of this parameter
MUST NOT equal the value passed in `hei_id`.

Note, that if both `hei_id` and `partner_hei_id` are given, then the client is
specifying two partners of the IIA, but IIAs MAY have more than two partners.
It's currently not allowed for the client to filter IIAs by more than two
partners.


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


### `modified_since` (optional)

A datetime string in the [`xs:dateTime` format][xs-datetime], e.g.
`2004-02-12T15:19:21+01:00`.

If given, then the server SHOULD filter the returned IIA IDs to the ones
which have been either created or modified after the given point in time.

 * Servers MAY include IIAs which were *not* modified. For example, if the
   server only *suspects* that the IIA has been modified, then it is okay to
   include such mobility's ID in the response.

 * Servers MAY ignore the `modified_since` parameter completely, and *always*
   respond with the full list of IIA IDs. (If, for some reason, the server
   cannot reliably identify when IIAs are updated, then it's even *better* to
   do so.)

 * As we previously explained [here][index-pulling], clients MAY use the
   `index` and `get` endpoints as a pull-based method of synchronization,
   alternative (or rather complementary) to CNRs. It is RECOMMENDED for the
   servers to support this parameter, to avoid unnecessary network traffic.


Permissions
-----------

You MUST return the set of all IDs which the requester has access to (via the
`get` endpoint). See the `get` endpoint for details on which IIAs should be
accessible by which requester.


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
[index-pulling]: https://github.com/erasmus-without-paper/ewp-specs-architecture#index-pulling
[xs-datetime]: https://www.w3.org/TR/xmlschema11-2/#dateTime
