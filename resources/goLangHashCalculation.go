package services_iias

import (
	"crypto/sha256"
	"encoding/hex"
	"encoding/xml"
	"strings"

	"github.com/ucarion/c14n"
)

func ExampleToCalculateHash(xmlPartnerCopyConditions, partnerHash string) (err error) {
	str, erro := prepareConditions(xmlPartnerCopyConditions)
	if erro != nil {
		// error! Could not Apply Exclusive Canonicalization to Cooperation Conditions.
		return
	}

	// Calculates the Hash
	hash, err := calculateHash(str)
	if err != nil {
		// error! Calculated Hash is different than the one fetched from the IIA.
		return
	}

	// Compares the calculated hash with the partner copy of the IIA's hash
	if partnerHash == hash {
		// error! Calculated Hash is different than the one fetched from the IIA.
		return
	}

	return
}

/**
	Applies Exclusive Cannonicalization to the XML of the Cooperation Conditions
	Adds the XMLNS to the cooperation-conditions tags
	Removes sending and receiving contacts from the conditions
**/
func prepareConditions(xmlPartnerCopyConditions string) (string, error) {

	// Developer may need to remove XML prologue and handle partner prefixes in the tags

	// Cannonicalize XML
	decoder := xml.NewDecoder(strings.NewReader(xmlPartnerCopyConditions))
	out, _ := c14n.Canonicalize(decoder)
	coopConditionsXML := string(out)

	// Add the xmlns to the cooperation-condition tag
	coopConditionsXML = strings.ReplaceAll(coopConditionsXML, "<cooperation-conditions>", "<cooperation-conditions xmlns=\"https://github.com/erasmus-without-paper/ewp-specs-api-iias/blob/stable-v6/endpoints/get-response.xsd\"")

	// Remove sending and receiving contacts from all conditions
	for {
		if strings.Contains(coopConditionsXML, "sending-contact>") {
			sending := strings.SplitAfter(coopConditionsXML, "<sending-contact>")
			sending2 := strings.SplitAfter(sending[1], "</sending-contact>")
			sending_s := strings.ReplaceAll(sending[0], "<sending-contact>", "")

			coopConditionsXML = sending_s + sending2[1]
			if len(sending) > 2 {
				var rec string
				for i := 2; i < len(sending); i++ {
					rec += sending[i]
				}
				coopConditionsXML += rec
			}
		} else {
			break
		}
	}

	for {
		if strings.Contains(coopConditionsXML, "receiving-contact>") {
			receiving := strings.SplitAfter(coopConditionsXML, "<receiving-contact>")
			receiving2 := strings.SplitAfter(receiving[1], "</receiving-contact>")
			receiving_s := strings.ReplaceAll(receiving[0], "<receiving-contact>", "")

			coopConditionsXML = receiving_s + receiving2[1]
			if len(receiving) > 2 {
				var rec string
				for i := 2; i < len(receiving); i++ {
					rec += receiving[i]
				}
				coopConditionsXML += rec
			}

		} else {
			break
		}
	}

	return coopConditionsXML, nil
}

/*
	Calculates the SHA 256 of a string
	In EWP context is used to calculate the Hash signature of the Cooperation Conditions
*/
func calculateHash(toBeCalculated string) (finalSHA string, err error) {

	hash := sha256.Sum256([]byte(toBeCalculated))
	slicedSHA := hash[:]
	finalSHA = hex.EncodeToString(slicedSHA)

	return
}
