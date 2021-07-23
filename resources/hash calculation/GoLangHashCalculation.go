package main

import (
	"crypto/sha256"
	"encoding/hex"
	"encoding/xml"
)

type iiasGetIIACoopsRespV6 struct {
	XMLName    xml.Name                        `xml:"cooperation-conditions"`
	XMLns      string                          `xml:"xmlns,attr,omitempty"`
	StudMob    []iiasGetIIACoopsStuStudeRespV6 `xml:"student-studies-mobility-spec"`     //0-inf
	StudTrain  []iiasGetIIACoopsStuTrainRespV6 `xml:"student-traineeship-mobility-spec"` //0-inf
	StaffTeach []iiasGetIIACoopsStaTeachRespV6 `xml:"staff-teacher-mobility-spec"`       //0-inf
	StaffTrain []iiasGetIIACoopsStaTrainRespV6 `xml:"staff-training-mobility-spec"`      //0-inf
}

type iiasGetIIACoopsStuStudeRespV6 struct {
	iiasGetIIACoopsStuRespBase
}

type iiasGetIIACoopsStuTrainRespV6 struct {
	iiasGetIIACoopsStuRespBase
}

type iiasGetIIACoopsStaTeachRespV6 struct {
	iiasGetIIACoopsStaRespBase
}

type iiasGetIIACoopsStaTrainRespV6 struct {
	iiasGetIIACoopsStaRespBase
}

type iiasGetIIACoopsStaRespBase struct {
	iiasGetIIACoopBase
	TOTDayPerYear float64 `xml:"total-days-per-year,omitempty"` //um ou outro xs:decimal min=0 and max 2 decimal
}

type iiasGetIIACoopsStuRespBase struct {
	iiasGetIIACoopBase
	TOTMonPerYear float64  `xml:"total-months-per-year,omitempty"` //um ou outro xs:decimal min=0 and max 2 decimal
	Blended       bool     `xml:"blended,omitempty"`               //um ou outro xs:decimal min=0 and max 2 decimal
	EqfLevel      []string `xml:"eqf-level,omitempty"`             //1-inf
}

type iiasGetIIACoopBase struct {
	SendHEI        string                           `xml:"sending-hei-id,omitempty"`
	SendOUnit      string                           `xml:"sending-ounit-id,omitempty"` //0-inf
	RecHEI         string                           `xml:"receiving-hei-id,omitempty"`
	RecOUnit       string                           `xml:"receiving-ounit-id,omitempty"`         //0-inf
	RecAcadYear    []string                         `xml:"receiving-academic-year-id,omitempty"` //1-inf
	MobPerYear     int                              `xml:"mobilities-per-year,omitempty"`
	RecLangSkill   []iiasGetIIACoopsRecLangResp     `xml:"recommended-language-skill,omitempty"` //0-inf
	SubjectArea    []iiasGetIIACoopsSubjectAreaResp `xml:"subject-area,omitempty"`               //0-unlimited
	OtherInfoTerms string                           `xml:"other-info-terms,omitempty"`           //0-unlimited
}

type iiasGetIIACoopsRecLangResp struct {
	Language    string                           `xml:"language,omitempty"`
	CEFRLevel   []typesCerfLevelResp             `xml:"cefr-level,omitempty"`   //[ABC][12] 0-1
	SubjectArea []iiasGetIIACoopsSubjectAreaResp `xml:"subject-area,omitempty"` //0-1
}

type typesCerfLevelResp struct {
	Value string `xml:",innerxml,regexp:'[ABC][12]'"` //pattern: [ABC][12]
}

type iiasGetIIACoopsSubjectAreaResp struct {
	ISCEDCode          string `xml:"isced-f-code,omitempty"`
	ISCEDClarification string `xml:"isced-clarification,omitempty"` //0-1
}

func calculateHash(student_mobility_array []iiasGetIIACoopsStuStudeRespV6, student_training_array []iiasGetIIACoopsStuTrainRespV6, staff_teaching_array []iiasGetIIACoopsStaTeachRespV6, staff_training_array []iiasGetIIACoopsStaTrainRespV6) {

	newCoopConds := iiasGetIIACoopsRespV6{
		StudMob:    student_mobility_array,
		StudTrain:  student_training_array,
		StaffTeach: staff_teaching_array,
		StaffTrain: staff_training_array,
	}

	newCoopConds.XMLns = newCoopConds.XMLName.Space
	finalSHA := ""
	coopStruct, err := xml.MarshalIndent(newCoopConds, "", "")

	if err != nil {
		// Error marshaling
		// Throw error
	} else {
		hash := sha256.Sum256([]byte(string(coopStruct)))
		slicedSHA := hash[:]
		finalSHA = hex.EncodeToString(slicedSHA)
		// Marshelling successful
	}

	if finalSHA == "" {
		// Hash not calculated
		// Throw error
	} else {
		// return hash
	}

}
