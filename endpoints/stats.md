IIA Stats endpoint
================

* [What is the status of this document?][statuses]
* [See the index of all other EWP Specifications][develhub]


Summary
-------

This endpoint allows the client to get the statistics describing IIAs from a local HEI.

Request method
--------------

 * Requests MUST be made with HTTP GET method.


Other requirements
------------------

Refer to [this document][ewp-architecture] for more details about requirements for statistics endpoint (TODO: update link for specific section after merging)


Error handling
------------------------------

 * General [error handling rules][error-handling] apply.

Response
--------

Servers MUST respond with a valid XML document described by the
[stats-response.xsd](stats-response.xsd) schema. See the schema annotations for
further information.


[develhub]: http://developers.erasmuswithoutpaper.eu/
[statuses]: https://github.com/erasmus-without-paper/ewp-specs-management#statuses
[iias-api]: https://github.com/erasmus-without-paper/ewp-specs-api-iias
[error-handling]: https://github.com/erasmus-without-paper/ewp-specs-architecture#error-handling
[ewp-architecture]: https://github.com/erasmus-without-paper/ewp-specs-architecture