Release notes
=============

This document describes all the changes made to the *Interinstitutional
Agreements API* document, starting from its first beta draft version.


0.3.0
-----

* New required `<iia-code>` element. Together with `<iia-id>` it allows server
  implementers to provide both surrogate and natural/business keys for all
  IIAs. Examples were updated appropriately to visualize the difference between
  them. See [this thread]
  (https://github.com/erasmus-without-paper/ewp-specs-api-mobilities/issues/9#issuecomment-271272493)
  for more reasoning.

* The `<isced-code>` element was renamed to `<isced-f-code>` ([why?]
  (https://github.com/erasmus-without-paper/ewp-specs-api-mobilities/issues/8#issuecomment-270402114)).

* New `<signing-date>` elements (one per each partner, as requested [here]
  (https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/7)).

* Explained the meaning of `<in-effect>` in more detail (see [this issue]
  (https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/9)).

* Explained from where the clients should fetch information on external HEIs
  and organization units (in particular, the ones which are not part of EWP
  yet). See [this thread]
  (https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/6).


0.2.0
-----

* Add a missing `<max-iia-ids>` element to `manifest-entry.xsd`.


0.1.0
-----

Initial release.
