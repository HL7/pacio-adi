Profile: PADIPreferenceCarePlan
Parent: CarePlan
Id: PADI-PreferenceCarePlan
Title: "ADI Preference Care Plan"
Description: "The Preference Care Plan is a means for an individual to express their goals and preferences under certain circumstances that may be pertinent when planning his or her care."

* text 0..1 MS

* status = #active
* intent = #proposal

* category ^slicing.discriminator.type = #pattern 
* category ^slicing.discriminator.path = "$this"
// Should the pattern be open or closed?
* category ^slicing.rules = #open
* category ^slicing.ordered = false   // can be omitted, since false is the default
* category ^slicing.description = "Slice based on $this value"
* category contains
    advance_care_planning 1..1 MS

* category[advance_care_planning] = $SNOMEDCT#736366004 "Advance care plan"
* title 1..1 MS

* subject 1..1 MS
* subject only Reference($USCorePatient)

* addresses 1..* MS
* addresses ^short = "Health issues this plan addresses (use display only for potential conditions the patient does not currently have)"
* addresses ^comment = "The conditions or circumstances in which the stated preferences and goals of the care plan apply. If there are no contained or referenceable resources (e.g. these are potential future conditions that do not represent a condition the patient currently has), the display should be in addresses.display. If no specific circumstances, then the display should indicate something like 'General' or 'All'"

* goal ^short = "Patient's preferences and goals for the scope of this care plan."
* goal 0..* 
* goal only Reference(PADIPersonalInterventionPreference or PADIPersonalGoal or PADICareExperiencePreference)

* extension contains
    padi-goal-order-by-descending-priority-extension named GoalOrderByDescendingPriority 0..1 