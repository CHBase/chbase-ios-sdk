//
//  HVClientResult.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

#if DEBUG
#define HV_DETAILEDTYPEERRORS 1
#endif

#define HVRESULT_SUCCESS [HVClientResult success]
#define HVERROR_UNKNOWN [HVClientResult unknownError]

#ifdef HV_DETAILEDTYPEERRORS
#define HVMAKE_ERROR(code) [HVClientResult fromCode:code fileName:__FILE__ lineNumber:__LINE__]
#else
#define HVMAKE_ERROR(code) [HVClientResult fromCode:code]
#endif


enum HVClientResultCode
{
    HVClientResult_Success = 0,
    //
    // Errors
    //
    HVClientError_Unknown,
    HVClientError_Web,
    HVClientEror_InvalidMasterAppID,
    HVClientError_UnknownServiceInstance,
    //
    // Base types
    //
    HVClientError_InvalidGuid,
    HVClientError_ValueOutOfRange,
    HVClientError_InvalidStringLength,
    //
    // Types
    //
    HVClientError_InvalidDate,
    HVClientError_InvalidTime,
    HVClientError_InvalidDateTime,
    HVClientError_InvalidApproxDateTime,
    HVClientError_InvalidCodedValue,
    HVClientError_InvalidCodableValue,
    HVClientError_InvalidDisplayValue,
    HVClientError_InvalidMeasurement,
    HVClientError_InvalidApproxMeasurement,
    HVClientError_InvalidWeightMeasurement,
    HVClientError_InvalidLengthMeasurement,
    HVClientError_InvalidBloodGlucoseMeasurement,
    HVClientError_InvalidConcentrationValue,
    HVClientError_InvalidVitalSignResult,
    HVClientError_InvalidNameValue,
    HVClientError_InvalidDuration,
    HVClientError_InvalidAddress,
    HVClientError_InvalidPhone,
    HVClientError_InvalidEmailAddress,
    HVClientError_InvalidEmail,
    HVClientError_InvalidContact,
    HVClientError_InvalidName,
    HVClientError_InvalidPerson,
    HVClientError_InvalidOrganization,
    HVClientError_InvalidPrescription,
    HVClientError_InvalidItemKey,
    HVClientError_InvalidRelatedItem,
    HVClientError_InvalidItemType,
    HVClientError_InvalidItemView,
    HVClientError_InvalidItemQuery,
    HVClientError_InvalidItem,
    HVClientError_InvalidRecordReference,
    HVClientError_InvalidRecord,
    HVClientError_InvalidPersonInfo,
    HVClientError_InvalidPendingItem,
    HVClientError_InvalidItemList,
    HVClientError_InvalidVocabIdentifier,
    HVClientError_InvalidVocabItem,
    HVClientError_InvalidVocabSearch,
    HVClientError_InvalidAssessmentField,
    HVClientError_InvalidOccurrence,
    HVClientError_InvalidRelative,
    HVClientError_InvalidFlow,
    HVClientError_InvalidVolume,
    HVClientError_InvalidMessageHeader,
    HVClientError_InvalidMessageAttachment,
    HVClientError_InvalidTestResultRange,
    HVClientError_InvalidLabTestResultValue,
    HVClientError_InvalidLabTestResultDetails,
    HVClientError_InvalidLabTestResultsGroup,
    //
    // Blobs
    //
    HVClientError_InvalidBlobInfo,
    //
    // Item Types
    //
    HVClientError_InvalidWeight,
    HVClientError_InvalidBloodPressure,
    HVClientError_InvalidCholesterol,
    HVClientError_InvalidBloodGlucose,
    HVClientError_InvalidHeight,
    HVClientError_InvalidExercise,
    HVClientError_InvalidAllergy,
    HVClientError_InvalidCondition,
    HVClientError_InvalidImmunization,
    HVClientError_InvalidMedication,
    HVClientError_InvalidProcedure,
    HVClientError_InvalidVitalSigns,
    HVClientError_InvalidEncounter,
    HVClientError_InvalidFamilyHistory,
    HVClientError_InvalidEmergencyContact,
    HVClientError_InvalidPersonalContactInfo,   
    HVClientError_InvalidBasicDemographics,
    HVClientError_InvalidPersonalDemographics,
    HVClientError_InvalidDailyMedicationUsage,
    HVClientError_InvalidAssessment,
    HVClientError_InvalidQuestionAnswer,
    HVClientError_InvalidSleepJournal,
    HVClientError_InvalidDietaryIntake,
    HVClientError_InvalidFile,
    HVClientError_InvalidCCD,
    HVClientError_InvalidCCR,
    HVClientError_InvalidInsurance,
    HVClientError_InvalidHeartRate,
    HVClientError_InvalidPeakFlow,
    HVClientError_InvalidMessage,
    HVclientError_InvalidLabTestResults,
    //
    // Store
    //
    HVClientError_Sync,
    HVClientError_PutLocalStore
};

@interface HVClientResult : NSObject
{    
    enum HVClientResultCode m_error;
    const char* m_file;
    int m_line;
}

@property (readonly, nonatomic) BOOL isSuccess;
@property (readonly, nonatomic) BOOL isError;

@property (readonly, nonatomic) enum HVClientResultCode error;
@property (readonly, nonatomic) const char* fileName;
@property (readonly, nonatomic) int lineNumber;

+(void) initialize;
-(id) init;
-(id) initWithCode:(enum HVClientResultCode)code;
-(id) initWithCode:(enum HVClientResultCode)code fileName:(const char *)fileName lineNumber:(int)line;

+(HVClientResult *) success;
+(HVClientResult *) unknownError;
+(HVClientResult *) fromCode:(enum HVClientResultCode) code;
+(HVClientResult *) fromCode:(enum HVClientResultCode)code fileName:(const char *)fileName lineNumber:(int)line;

@end