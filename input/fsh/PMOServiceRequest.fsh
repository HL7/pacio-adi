Profile: ADIPMOServiceRequest
Parent: $USCoreServiceRequest
Id: ADI-PMOServiceRequest
Title: "ADI PMO ServiceRequest"
Description: "This profile is used to represent both a patient authored care plan (PACP) and a practitioner authored portable medical order (PMO)."

/*
* extension contains
    adi-based-on-consent-extension named BasedOnConsentExtension 0..1
*/
//* text 1..1 MS

* status = #active
* intent = #order

// TODO need a category 
// TODO may need to get a variance request from us core ServiceRequest. In different version and also do any of the categories fit?
// http://hl7.org/fhir/us/core/STU5.0.1/ValueSet-us-core-servicerequest-category.html

* category 1..* MS
* code 1..1 MS


/* extension contains
    adi-based-on-consent-extension named BasedOnConsentExtension 0..1
*/
//* code = $LOINC#75781-5

* subject 1..1
* subject only Reference($USCorePatient)

* occurrencePeriod ^short = "Used to specify when the PMO Medical Order goes into effect." 
* occurrencePeriod.start 1..1 MS

* encounter 0..0 // verify no encounter possible
* requester 1..1
* requester only Reference($USCorePractitioner)




Profile: ADIPMOCPRServiceRequest
Parent: ADIPMOServiceRequest
Id: ADI-PMOCPRServiceRequest
Title: "ADI PMO Cardiopulmonary Resuscitation ServiceRequest"
Description: "This profile is used to represent a practitioner authored portable medical order for cardiopulmonary resuscitation."

* status = #active
* intent = #order

* ^experimental = false
* category = $LOINC#100822-6 "Cardiopulmonary resuscitation orders"
* code = $LOINC#100822-6 "Cardiopulmonary resuscitation orders" // from LOINCPOLSTCPRAnswerList (extensible)
* doNotPerform 0..1 MS


Profile: ADIPMOInitialTreatmentServiceRequest
Parent: ADIPMOServiceRequest
Id: ADI-PMOInitialTreatmentServiceRequest
Title: "ADI PMO Initial Treatment ServiceRequest"
Description: "This profile is used to represent a practitioner authored portable medical order for initial treatment."

* status = #active
* intent = #order

* ^experimental = false
* category = $LOINC#100823-4 "Initial portable medical treatment orders"
* code = $LOINC#100823-4 "Initial portable medical treatment orders" // from LOINCPOLSTInitialTxAnswerList (extensible)


Profile: ADIPMOAdditionalOrdersOrInstructionsServiceRequest
Parent: ADIPMOServiceRequest
Id: ADI-PMOAdditionalOrdersOrInstructionsServiceRequest
Title: "ADI PMO Additional orders or instructions ServiceRequest"
Description: "This profile is used to represent a practitioner authored portable medical order additional orders or instructions."

* status = #active
* intent = #order

* ^experimental = false
* category = $LOINC#100824-2 "Additional portable medical orders or instructions"
* code 1..1 MS


Profile: ADIPMOMedicallyAssistedNutritionServiceRequest
Parent: ADIPMOServiceRequest
Id: ADI-PMOMedicallyAssistedNutritionServiceRequest
Title: "ADI PMO Medically Assisted Nutrition Service Request"
Description: "This profile is used to represent a practitioner authored portable medical order for medically assisted nutrition."

* ^experimental = false
* category = $LOINC#100825-9 "Medically assisted nutrition orders"
* code from LOINCPOLSTMedAssistNutrAnswerList (extensible)

Profile: ADIPMOMedicallyAssistedHydrationServiceRequest
Parent: ADIPMOServiceRequest
Id: ADI-PMOMedicallyAssistedHydrationServiceRequest
Title: "ADI PMO Medically Assisted Hydration Service Request"
Description: "This profile is used to represent a practitioner authored portable medical order for medically assisted hydration."

* status = #active
* intent = #order

* ^experimental = false
* category = ADITempCS#pmo-medically-assisted-hydration-service-request "Medically assisted hydration order"
* code 1..1 MS // TO DO: create valueset of hydration orders with an extensible binding.

/////////////////////////////////
// PMO as full service Request
/*
Profile: ADIPMOFullServiceRequest
Parent: ServiceRequest
Id: ADI-PMOFullServiceRequest
Title: "ADI Portable Medical Order Full ServiceRequest"
Description: "This profile is used to represent a practitioner authored portable medical order."

* text 1..1 MS

* status = #active
* intent = #order

// TODO need a category 
// TODO may need to get a variance request from us core ServiceRequest. In different version and also do any of the categories fit?
// http://hl7.org/fhir/us/core/STU5.0.1/ValueSet-us-core-servicerequest-category.html

* category 1..1 MS
* code 1..1 MS

//* code = $LOINC#75781-5

* subject 1..1
* subject only Reference($USCorePatient)

* encounter 0..0 // verify no encounter possible
* requester only Reference($USCorePractitioner)

* ^experimental = false
* category = $LOINC#100822-6 // "Cardiopulmonary resuscitation orders"
* code from LOINCPOLSTCPRAnswerList (extensible)

*/