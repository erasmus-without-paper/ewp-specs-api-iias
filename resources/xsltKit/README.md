The XSLT templates, Java class example and this explanation are based on
[this comment](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/109#issuecomment-1593875245)
and inspired by [this comment](https://github.com/erasmus-without-paper/ewp-specs-api-iias/issues/109#issuecomment-1569982153).

### Short explanation

The result of the [XSLT transformation](transform_version_6.xsl) for
[IIA version v6 example](https://raw.githubusercontent.com/erasmus-without-paper/ewp-specs-api-iias/stable-v7/resources/xsltKit/get-response-v6.xml):

```
<?xml version="1.0" encoding="UTF-8"?>
<iia>
    <iia-id>0f7a5682-faf7-49a7-9cc7-ec486c49a281</iia-id>
    <text-to-hash>_iia-id_1=0f7a5682-faf7-49a7-9cc7-ec486c49a281__iia-id_2=1954991__cooperation-conditions.student-studies-mobility-spec.sending-hei-id=uw.edu.pl__cooperation-conditions.student-studies-mobility-spec.sending-ounit-id=140__cooperation-conditions.student-studies-mobility-spec.receiving-hei-id=hibo.no__student-studies-mobility-spec.subject-area.isced-f-code=031__student-studies-mobility-spec.subject-area.isced-clarification=Social and behavioural sciences__cooperation-conditions.student-studies-mobility-spec.total-months-per-year=5__cooperation-conditions.student-studies-mobility-spec.blended=false__cooperation-conditions.student-studies-mobility-spec.eqf-level=7__cooperation-conditions.student-studies-mobility-spec.eqf-level=8__receiving-first-academic-year-id=2014/2015__receiving-last-academic-year-id=2020/2021__cooperation-conditions.staff-teacher-mobility-spec.sending-hei-id=uw.edu.pl__cooperation-conditions.staff-teacher-mobility-spec.sending-ounit-id=140__cooperation-conditions.staff-teacher-mobility-spec.receiving-hei-id=hibo.no__cooperation-conditions.staff-teacher-mobility-spec.mobilities-per-year=2__staff-teacher-mobility-spec.recommended-language-skill.language=en__staff-teacher-mobility-spec.recommended-language-skill.cefr-level=C1__staff-teacher-mobility-spec.subject-area.isced-f-code=0314__cooperation-conditions.staff-teacher-mobility-spec.total-days-per-year=8__receiving-first-academic-year-id=2016/2017__receiving-last-academic-year-id=2017/2018_</text-to-hash>
</iia>
```

It has the same `text-to-hash` value as the result we obtain if we apply the [XSLT transformation](transform_version_7.xsl) for
[IIA version v7 example](https://raw.githubusercontent.com/erasmus-without-paper/ewp-specs-api-iias/stable-v7/resources/xsltKit/get-response-v7.xml):

```
<?xml version="1.0" encoding="UTF-8"?>
<iia>
    <iia-id>0f7a5682-faf7-49a7-9cc7-ec486c49a281</iia-id>
    <text-to-hash>_iia-id_1=0f7a5682-faf7-49a7-9cc7-ec486c49a281__iia-id_2=1954991__cooperation-conditions.student-studies-mobility-spec.sending-hei-id=uw.edu.pl__cooperation-conditions.student-studies-mobility-spec.sending-ounit-id=140__cooperation-conditions.student-studies-mobility-spec.receiving-hei-id=hibo.no__student-studies-mobility-spec.subject-area.isced-f-code=031__student-studies-mobility-spec.subject-area.isced-clarification=Social and behavioural sciences__cooperation-conditions.student-studies-mobility-spec.total-months-per-year=5__cooperation-conditions.student-studies-mobility-spec.blended=false__cooperation-conditions.student-studies-mobility-spec.eqf-level=7__cooperation-conditions.student-studies-mobility-spec.eqf-level=8__receiving-first-academic-year-id=2014/2015__receiving-last-academic-year-id=2020/2021__cooperation-conditions.staff-teacher-mobility-spec.sending-hei-id=uw.edu.pl__cooperation-conditions.staff-teacher-mobility-spec.sending-ounit-id=140__cooperation-conditions.staff-teacher-mobility-spec.receiving-hei-id=hibo.no__cooperation-conditions.staff-teacher-mobility-spec.mobilities-per-year=2__staff-teacher-mobility-spec.recommended-language-skill.language=en__staff-teacher-mobility-spec.recommended-language-skill.cefr-level=C1__staff-teacher-mobility-spec.subject-area.isced-f-code=0314__cooperation-conditions.staff-teacher-mobility-spec.total-days-per-year=8__receiving-first-academic-year-id=2016/2017__receiving-last-academic-year-id=2017/2018_</text-to-hash>
    <valid-for-approval>false</valid-for-approval>
</iia>
```

We should next hash the value of the `text-to-hash` element with an SHA-256 algorithm to obtain the new `iia-hash` element value.

The transformation can manage changes to IIA introduced in version 7 of the API. It also reflects changes to IIA mapping.
Thanks to the `not-yet-defined` attribute it manages elements that are required by the new version but cannot be provided automatically for the old IIAs.
Also `v6-value` attribute of the `isced-f-code` element is used to acquire the old ISCED code value as defined in IIA version 6. 

When an IIA contains an element with `not-yet-defined` or `v6-value` attribute,
the transformation adds a `<valid-for-approval>false</valid-for-approval>` sub-element as the last child of the `<iia>` element.
It informs that this IIA misses some values which are required in IIA v7, and it cannot be approved.

To transform an XML, you may need to find the right processor,
e.g., for Java Saxon-HE version 12.4 has been tested.

We provide an example in Java that transforms an IIA XML (as a byte array) via the XSLT (as a byte array too) and obtain the above-mentioned XML:

```
public String getXmlTransformed(byte xmlBytes[], byte xsltBytes[]) throws Exception
  {
    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
    dbf.setNamespaceAware(true);
      
    DocumentBuilder db = dbf.newDocumentBuilder();
    Document document = db.parse(new ByteArrayInputStream(xmlBytes)); 
    
    TransformerFactory transformerFactory = TransformerFactory.newInstance();
    Transformer transformer = transformerFactory.newTransformer(
                                                    new StreamSource(new ByteArrayInputStream(xsltBytes)));
    ByteArrayOutputStream output = new ByteArrayOutputStream();
     
    transformer.transform(new DOMSource(document), new StreamResult(output));
     
    return new String(output.toByteArray());
  } 
```

The solution described here consists of the following resources:
- [transform_version_6.xsl](transform_version_6.xsl) to be used with your IIA v6,
- [transform_version_7.xsl](transform_version_7.xsl) to be used with your IIA v7,
- [XsltTest.java](XsltTest.java) to transform an IIA XML using one of the above-mentioned XSLTs.


### Further explanation


The XSLT produces one `<iia>` element for every `<iia>` element present in the IIA Get response.
The `<iia-id>` sub-element can be used to identify each IIA.

Every `<iia>` element has two sub-elements and optionally a third one:
 - `<iia-id>` to indicate the associated IIA ID,
 - `<text-to-hash>` to expose the string built as a concatenation of all the leaf elements (elements without children)
   separated by an underscore (e.g.: `_parent.child=myValue_`).
   Each element value is preceded with the element and ancestor names separated by a dot and a `=` sign.
   Before every element we have the values of its attributes (if they exist);
   they are represented inside two markers` _@ `and `@_ `(e.g. `_@attributeValue@_`). There are some additional rules:
   - the `<text-to-hash>` element contains both IIA IDs (sending and receiving) and their position in the XML; so it changes when IIA mapping changes,
   - the `<text-to-hash>` element does not contain:
     - the sending/receiving contacts (for both of v6 and v7 XSLT)
     - the `receiving-academic-year-id` (only for v6 XSLT)
     - the `receiving-first-academic-year-id` and the `receiving-last-academic-year-id` (only for v7 XSLT)
   - the `<text-to-hash>` element contains, at the end of every mobility:
     - for XSLT v6: the values of the first and last occurrence of the receiving-academic-year-id element
     - for XSLT v7: the values of the receiving-first-academic-year-id and receiving-last-academic-year-id
   - the `<text-to-hash>` element does not contain (only for v7):
     - all the elements having the attribute `not-yet-defined`; this attribute is never printed in the output,
   - the `isced-f-code` element value is replaced with the `v6-value` attribute value if defined (only for v7),
 - `<valid-for-approval>` is present and set to false if the IIA v7 contains:
   - an element with the `not-yet-defined` attribute set to true,
   - or an element with the `v6-value` attribute.

The `<valid-for-approval>` element carries information whether the current XML contains all the values required in IIA v7 and accepted by the user.

To test the XSLT against your IIA Get response XMLs you can use those online tools:
 - https://linangdata.com/xslt-tester/
 - http://xsltransform.net/

To compute the hash code you can use:
 - https://www.fileformat.info/tool/hash.htm