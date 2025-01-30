Profile: ADIHealthcareAgentConsent
Parent: Consent
Id: ADI-HealthcareAgentConsent
Title: "ADI Healthcare Agent Consent"
Description: "This profile is used to represent a consent for an advance directive participant such as a healthcare agent or advisor and power or limitation granted to such persons."

* ^abstract = true
// * obeys HCA-authority-scope-provisionType // provisionType invariant no longer needed since we fix scope to only one LOINC code (81377-4)
* obeys HCA-consent-category
* obeys HCA-provision-purpose

* text 1..1 MS

* status MS
* status = #active
// * scope from $VSACADIConsentType (required)  
* scope = $LOINC#81377-4 "Goals, preferences, and priorities regarding the appointment of healthcare agents [Reported]" // mlt: fixed to LOINC 81377-4 per (FHIR-48900)

// Fix for FHIR_34506 - meeting on 2023-08-28: re-point to http://terminology.hl7.org/CodeSystem/consentcategorycodes
/*
	* Create a fixed value of acd for the consent type.
	* Write in narrative what our interpretation of the existing code.
*/

* category 1..1 MS
* category = $HL7ConsentCategoryCodes#acd
// * category from $HL7ConsentCategoryVS (extensible)


* patient 1..1 MS
* patient only Reference($USCorePatient)
* dateTime MS

// [TODO] Where is the appropriate place to state that this Consent is for an agent 
* policy MS
* policy ^comment = "A URI indicating the policy or jurisdiction that defines the policy for healthcare agents and granted powers and limitations."

* provision 1..1 MS

* provision.extension contains
    adi-clause-extension named ClauseExtension 0..*


* provision.type 1..1 MS
* provision.period 
//[TODO] do we need to support and require provision.actor for all HCA's?
* provision.actor 1..* MS


* provision.actor.extension contains
    adi-clause-extension named ClauseExtension 0..*
    
* provision.actor.role from $VSACADIConsentActorRole (required)
* provision.actor.reference only Reference(ADIHealthcareAgentParticipant)

* provision.action from ADIHCADecisionsVS (extensible)
* provision.action ^comment = "Actions without a defined code are placed in action.text."
* provision.purpose from http://terminology.hl7.org/ValueSet/v3-ActReason (required)


Profile: ADIConsentPermit
Parent: ADIHealthcareAgentConsent
Id: ADI-ADIConsentPermit
Title: "ADI Healthcare Agent Consent Permit"
Description: "This profile is used to represent permit consents for an advance directive participant such as a healthcare agent or advisor and power or limitation granted to such persons."

* provision.type = #permit

Profile: ADIConsentDeny
Parent: ADIHealthcareAgentConsent
Id: ADI-ADIConsentDeny
Title: "ADI Healthcare Agent Consent Deny"
Description: "This profile is used to represent deny consents for an advance directive participant such as a healthcare agent or advisor and power or limitation granted to such persons."

* provision.type = #deny


// [TODO] need to add guidance that first provision is the base set of rules, and the nested ones are exceptions to the rules.
// This may tke 2 forms, either a permit as a base rule with exceptions stating what is type deny, or vice versa.

// examples of provisions in OneNote - Powers & Limitation Examples for consent

/*
    i.      My agent is authorized to
    ii.      __Consent, refuse, or withdraw consent to any care, procedure, treatment, or service to diagnose, treat, or maintain a physical or mental condition, including artificial nutrition and hydration;
    iii.      __Permit, refuse, or withdraw permission to participate in federally regulated research related to my condition or disorder;
    iv.      __Make all necessary arrangements for any hospital, psychiatric treatment facility, hospice, nursing home, or other healthcare organization; and, employ or discharge healthcare personnel (any person who is authorized or permitted by the laws of the state to provide healthcare services) as he or she shall deem necessary for my physical, mental, or emotional well-being;
    v.      __Request, receive, review, and authorize sending any information regarding my physical or mental health, or my personal affairs, including medical and hospital records; and execute any releases that may be required to obtain such information;
    vi.      __Move me into or out of any State or institution;
    vii.      __Take legal action, if needed;
    viii.      __Make decisions about autopsy, tissue and organ donation, and the disposition of my body in conformity with state law; and
    ix.      __Become my guardian if one is needed.

*/


/* 
Invariant:  HCA-authority-scope-provisionType
Description: "Scope indicates powers granted and provision type is permit or scope indicates limitations placed and provision type is deny or scope indicates no powers/limitations and no provisions type and no action exist"
Expression: "(scope.coding.where(code = '81377-4').exists() and provision.type = 'permit') or (scope.coding.where(code = '81346-9').exists() and provision.type = 'deny') or (scope.coding.where(code = '81335-2').exists() and provision.type.exists().not() and provision.action.exists().not() and provision.provision.exists().not())"
Severity:   #error
*/

Invariant: HCA-consent-category
Description: "Category must have a ConsentCategory of 'acd'"
Expression: "category.coding.where(code = 'acd').exists()"
Severity:   #error

Invariant: HCA-provision-purpose
Description: "Provision purpose must have a purpose of 'PWATRNY'"
Expression: "provision.purpose.exists().not() or provision.purpose.where(code = 'PWATRNY').exists()"
Severity:   #error
