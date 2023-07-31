Release notes
=============

This document describes all the changes made to the *Interinstitutional
Agreements API* document, starting from its first beta draft version.

6.3.0
-----

* Added rules about IIA termination and modification.
* Added rules describing IIA deletion.
* Improved ISCED clarification field description (#87).
* Fixed wording in conditions-hash documentation.
* IIAs Dashboard Exchange Scenarios (#93).
* Added Mandatory Business requirements document.
* Fixed wrong API name in documentation.


6.2.0
-----

* Add IIAs statistics endpoint.


6.1.0
-----

* Fix description of sending-ounit-id and receiving-ounit-id.
* Remove incorrect comment to the EQF level field in the example.
* Add note about XML Canonicalization and spaces.
* Changing the hash to correctly calculated in get response example.
* Fix #69 by using a more generic description for signing-contact.
* Add a link to the current IIA template.
* Better indication of the template used to model IIA.
* Fix #61 by rewording comment to EQL level.
* Make mobilities per year element strongly recommended.
* Require academic years to be ordered and without gaps (#70).
* Emphasise that partner agreement ID should be provided ASAP.
* Fix example scenario so that IIA approval is after ID mapping.
* Add important rules of IIA exchange.
* Change "should" to "must" for many CC support.
* Change "should" to "highly recommend" for matching partner fields.


6.0.1
-----

* Fix namespace version number in manifest-entry.xsd.


6.0.0
-----

* Limit sending-ounit-id and receiving-ounit-id to one element.
* Update link to the PDF describing ISCED-F codes.
* Fix #49 by adding note about the recommended format for ISCED code.
* Exclude sending-contact and receiving-contact when calculating hash.
* Fix descriptions of iia-id and iia-code fields.
* Make sending CNRs mandatory.


5.0.0
-----

* Add note about setting "blended" to false for "legacy" agreements.
* Rename "total-months" and "total-days" fields.
* Change name of "subject-area-name" element to "isced-clarification".
* Add field for other information regarding the terms of the agreement.
* Add optional subject area inside "recommended-language-skill".
* Make "mobilities-per-year" element optional and remove note.
* Add EQF level element also for student traineeship.
* Make EQF level optional.
* Make blended element required.
* Remove referenced to multi-party agreements.


4.0.0
-----

* Allow many ISCED codes in mobility specification.


3.0.0
-----

* Remove average duration and make total required.
* Add `blended` flag for student mobilities.
* Change namespaces due to a major release.


2.2.2
-----

* Add template for Calls 2021-2027.


2.2.1
-----

* Add PDFs to the examples.


2.2.0
-----

* Add optional `<conditions-hash>` element to the get response.
  It is necessary to be able to get approval of the IIA via `IIAs Approval API`.
* Add example scenario of sending and approving agreement.
* Add PDF to the get response.
* Add optional `send_pdf` request parameter.


2.1.0
-----

* **Changed data type** of the following elements:

  - `<avg-months>` (in `StudentMobilitySpecification`),
  - `<total-months>` (in `StudentMobilitySpecification`),
  - `<avg-days>` in (in `StaffMobilitySpecification`),
  - `<total-days>` in (in `StaffMobilitySpecification`).

  Previously, these elements contained `xs:positiveInteger`. Now, they contain
  a positive decimal with the maximum of 2 fraction digits.

  This changed is **not backward compatible** with respect the API clients
  (clients might have already assumed that they will get an integer in these
  elements, but this is no longer guaranteed). Despite that fact, partners have
  agreed to NOT increase the major version of the API (because of the very
  limited number of implemented API clients). See
  [this thread](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/23).


2.0.1
-----

* The `modified_since` parameter of the `index` endpoint is now in the
  `xs:dateTime` format (not ISO 8601 format). See
  [this thread](https://github.com/erasmus-without-paper/general-issues/issues/27).

  Note, that this change is not 100% backward-compatible, so - in theory -
  we should release version `3.0.0` at this point. Instead, we judged it would
  be better to treat this change as a bugfix (because it's *almost* compatible
  as it is, and releasing a new major version would complicate things).


2.0.0
-----

 * This API now requires implementers to upgrade their implementations to
   [Version 2](https://github.com/erasmus-without-paper/ewp-specs-sec-intro/tree/stable-v2)
   of the *Authentication and Security* document.

   In particular, this means that the clients MUST be aware of the fact, that
   the server is no longer required to support methods of authentication and
   encryption which it *was* required to support in the previous versions of
   this API. Clients SHOULD consult the newly introduced `<http-security>`
   element in the server's manifest entry before making their requests.

 * Because we are releasing a new major release (which is no longer
   backward-compatible with the previously released stable `1.x.x` releases),
   XML namespaces were changed to reflect that.

   In particular, API-entry namespace was changed from:

   ```
   https://github.com/erasmus-without-paper/ewp-specs-api-iias/blob/stable-v1/manifest-entry.xsd
   ```

   to:

   ```
   https://github.com/erasmus-without-paper/ewp-specs-api-iias/blob/stable-v2/manifest-entry.xsd
   ```

   Get-endpoint response namespace was changed from:

   ```
   https://github.com/erasmus-without-paper/ewp-specs-api-iias/blob/stable-v1/endpoints/get-response.xsd
   ```

   to:

   ```
   https://github.com/erasmus-without-paper/ewp-specs-api-iias/blob/stable-v2/endpoints/get-response.xsd
   ```

   And Index-endpoint namespace was changed from:

   ```
   https://github.com/erasmus-without-paper/ewp-specs-api-iias/blob/stable-v1/endpoints/index-response.xsd
   ```

   to:

   ```
   https://github.com/erasmus-without-paper/ewp-specs-api-iias/blob/stable-v2/endpoints/index-response.xsd
   ```


1.0.1
-----

* Explicitly declare that this version still requires the use of
  [Version 1](https://github.com/erasmus-without-paper/ewp-specs-sec-intro/tree/stable-v1)
  of the *Authentication and Security* document. You can find more information
  on the planned process of updating security requirements
  [here](https://github.com/erasmus-without-paper/ewp-specs-sec-intro/issues/1).


1.0.0
-----

* First stable release!
* Clean up: Replaced all relative schemaLocations with absolute ones.


0.9.0
-----

* Changed XML namespaces (as part of
  [this issue](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/22)).
  Since this version, this API is in the `stable-v1` XML namespace.


0.8.1
-----

* Minor fixes in XSD's "style".


0.8.0
-----

* New parameter in the `index` endpoint: `modified_since`. It is RECOMMENDED
  for the servers to support this parameter, to avoid unnecessary network
  traffic.


0.7.0
-----

* `total-days` and `total-months` were introduced as a valid alternative to
  `avg-days` and `avg-months`
  ([why?](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/17)).


0.6.0
-----

* New request parameter: `partner_hei_id`. (Servers are required to support
  it.)


0.5.0
-----

* Academic Term and Abstract Contact data types are now in `stable-v1`
  namespace
  ([more information](https://github.com/erasmus-without-paper/general-issues/issues/24)).

* Introduced limits on IIA ID values
  ([more information](https://github.com/erasmus-without-paper/general-issues/issues/23)).

* `minOccurs` and `maxOccurs` are now provided explicitly
  ([why?](https://github.com/erasmus-without-paper/general-issues/issues/22)).


0.4.0
-----

Major changes in document structure:

* Optional `<ounit-id>` element has been added for each partner. The
  `<partner-hei>` element has been renamed to `<partner>` (because a partner
  can now refer to an Organizational Unit, not only a HEI). See
  [this thread](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/11).

* All the elements describing the "local partner" were removed. The local
  partner is now described the same way any other partner is - via the
  `<partner>` element (the first of them, to be exact). See
  [this thread](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/13).

Other changes:

* New `iia_code` parameter was added to allow requesters searching for IIAs
  by their codes (the server is now REQUIRED to support this parameter).
  Providing `iia_id` parameter is no longer required, if the requester provides
  the `iia_code` parameter instead. This is a part of a larger change in all
  APIs described
  [here](https://github.com/erasmus-without-paper/general-issues/issues/21).

* Start and end dates were removed. They MAY return again, if we can define
  more clearly what they mean and what they can be used for (by the client).
  Discuss [here](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/10).

* Clarified which IIAs should be accessible by whom. Clarified what servers
  should do if in their model the *end date* of a cooperation condition can be
  unspecified.

* Modified the `<contact>` elements in examples to fit recent additions to the
  [Abstract Contact Type](https://github.com/erasmus-without-paper/ewp-specs-types-contact).


0.3.0
-----

* New required `<iia-code>` element. Together with `<iia-id>` it allows server
  implementers to provide both surrogate and natural/business keys for all
  IIAs. Examples were updated appropriately to visualize the difference between
  them. See [this thread](https://github.com/erasmus-without-paper/ewp-specs-api-omobilities/issues/9#issuecomment-271272493)
  for more reasoning.

* The `<isced-code>` element was renamed to `<isced-f-code>`
  ([why?](https://github.com/erasmus-without-paper/ewp-specs-api-omobilities/issues/8#issuecomment-270402114)).

* New `<signing-date>` elements (one per each partner, as requested
  [here](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/7)).

* Explained the meaning of `<in-effect>` in more detail (see
  [this issue](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/9)).

* Explained from where the clients should fetch information on external HEIs
  and organization units (in particular, the ones which are not part of EWP
  yet). See [this thread](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/6).


0.2.0
-----

* Added a missing `<max-iia-ids>` element to `manifest-entry.xsd`.


0.1.0
-----

Initial release.
