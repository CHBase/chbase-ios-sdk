//
//  HVItemTypes.h
//  HVLib
//
//

#import "HVWeight.h"
#import "HVBloodPressure.h"
#import "HVCholesterol.h"
#import "HVCholesterolV2.h"
#import "HVBloodGlucose.h"
#import "HVCholesterolV2.h"
#import "HVHeartRate.h"
#import "HVHeight.h"
#import "HVPeakFlow.h"
#import "HVExercise.h"
#import "HVDailyMedicationUsage.h"
#import "HVEmotionalState.h"
#import "HVSleepJournalAM.h"
#import "HVSleepJournalPM.h"
#import "HVDietaryIntake.h"
#import "HVDailyDietaryIntake.h"
#import "HVAllergy.h"
#import "HVCondition.h"
#import "HVImmunization.h"
#import "HVMedication.h"
#import "HVProcedure.h"
#import "HVVitalSigns.h"
#import "HVEncounter.h"
#import "HVFamilyHistory.h"
#import "HVCCD.h"
#import "HVCCR.h"
#import "HVInsurance.h"
#import "HVEmergencyOrProviderContact.h"
#import "HVPersonalContactInfo.h"
#import "HVBasicDemographics.h"
#import "HVPersonalDemographics.h"
#import "HVPersonalImage.h"
#import "HVAssessment.h"
#import "HVQuestionAnswer.h"
#import "HVFile.h"
#import "HVMessage.h"
#import "HVLabTestResults.h"
#import "HVItemRaw.h"

@interface HVItem (HVTypedExtensions)

-(HVItemDataTyped *) getDataOfType:(NSString *) typeID;

-(HVWeight *) weight;
-(HVBloodPressure *) bloodPressure;
//
// Deprecated. Use cholesterolV2
//
-(HVCholesterol *) cholesterol;
-(HVCholesterolV2 *) cholesterolV2;
-(HVBloodGlucose *) bloodGlucose;
-(HVHeight *) height;
-(HVHeartRate *) heartRate;
-(HVPeakFlow *) peakFlow;
-(HVExercise *) exercise;
-(HVDailyMedicationUsage *) medicationUsage;
-(HVEmotionalState *) emotionalState;
-(HVAssessment *) assessment;
-(HVQuestionAnswer *) questionAnswer;
-(HVDailyDietaryIntake *) dailyDietaryIntake;
-(HVDietaryIntake *) dietaryIntake;
-(HVSleepJournalAM *) sleepJournalAM;
-(HVSleepJournalPM *) sleepJournalPM;

-(HVAllergy *) allergy;
-(HVCondition *) condition;
-(HVImmunization *) immunization;
-(HVMedication *) medication;
-(HVProcedure *) procedure;
-(HVVitalSigns *) vitalSigns;
-(HVEncounter *) encounter;
-(HVFamilyHistory *) familyHistory;
-(HVCCD *) ccd;
-(HVCCR *) ccr;
-(HVInsurance *) insurance;
-(HVMessage *) message;
-(HVLabTestResults *) labResults;

-(HVEmergencyOrProviderContact *) emergencyOrProviderContact;
-(HVPersonalContactInfo *) personalContact;

-(HVBasicDemographics *) basicDemographics;
-(HVPersonalDemographics *) personalDemographics;
-(HVPersonalImage *) personalImage;

-(HVFile *) file;

@end
