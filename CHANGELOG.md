Release notes
=============

This document describes all the changes made to the *Interinstitutional
Agreements API* document, starting from its first beta draft version.


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
  them. See [this thread](https://github.com/erasmus-without-paper/ewp-specs-api-mobilities/issues/9#issuecomment-271272493)
  for more reasoning.

* The `<isced-code>` element was renamed to `<isced-f-code>`
  ([why?](https://github.com/erasmus-without-paper/ewp-specs-api-mobilities/issues/8#issuecomment-270402114)).

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
