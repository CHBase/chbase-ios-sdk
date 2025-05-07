//
//  HVItemTypes.h
//  HVLib
//
//

#import "HVWeight.h"
#import "HVBloodPressure.h"
#import "HVCholesterol.h"
#import "HVCholesterolV2.h"
#import "HVAppSpecificInformation.h"
#import "HVMedicationFill.h"
#import "HVAsthmaInhaler.h"
#import "HVAsthmaInhalerUsage.h"
#import "HVInsulinInjectionUsage.h"
#import "HVInsulinInjection.h"
#import "HVReferral.h"
#import "HVSleepSession.h"
#import "HVBloodOxygenSaturation.h"
#import "HVBodyDimension.h"
#import "HVStatus.h"
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
#import "HVWebLink.h"
#import "HVComment.h"
#import "HVConcern.h"
#import "HVAppointment.h"
#import "HVBmi.h"
#import "HVHba1c.h"
#import "HVAdvanceDirectiveV2.h"
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
-(HVWebLink *) weblink;
-(HVComment *) comment;
-(HVConcern *) concern;
-(HVAppointment *) appointment;
-(HVBmi *) bmi;
-(HVHba1c *) hba1c;
-(HVAdvanceDirectiveV2 *) advancedirectivev2;
-(HVCondition *) condition;
-(HVImmunization *) immunization;
-(HVMedication *) medication;
-(HVProcedure *) procedure;
-(HVAppSpecificInformation *) appSpecificInformation;
-(HVVitalSigns *) vitalSigns;
-(HVMedicationFill *) medicationFill;
-(HVEncounter *) encounter;
-(HVAsthmaInhaler *) asthmaInhaler;
-(HVFamilyHistory *) familyHistory;
-(HVAsthmaInhalerUsage *) asthmaInhalerUsage;
-(HVCCD *) ccd;
-(HVInsulinInjectionUsage *) insulinInjectionUsage;
-(HVCCR *) ccr;
-(HVInsulinInjection *) insulinInjection;
-(HVInsurance *) insurance;
-(HVReferral *) referral;
-(HVMessage *) message;
-(HVSleepSession *) sleepSession;
-(HVLabTestResults *) labResults;
-(HVBloodOxygenSaturation *) bloodOxygenSaturation;

-(HVBodyDimension *) bodyDimension;
-(HVEmergencyOrProviderContact *) emergencyOrProviderContact;
-(HVStatus *) status;
-(HVPersonalContactInfo *) personalContact;

-(HVBasicDemographics *) basicDemographics;
-(HVPersonalDemographics *) personalDemographics;
-(HVPersonalImage *) personalImage;

-(HVFile *) file;

@end
