//
//  HVExercise.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVExercise : HVItemDataTyped
{
@private
    HVApproxDateTime* m_when;
    HVCodableValue* m_activity;
    NSString* m_title;
    HVLengthMeasurement* m_distance;
    HVPositiveDouble* m_duration;
    HVNameValueCollection* m_details;
    NSMutableArray* m_segmentsXml;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) When did you do this exercise
//
@property (readwrite, nonatomic, retain) HVApproxDateTime* when;
//
// (Required) What activity did you perform?
// Preferred Vocabulary: exercise-activities
//
@property (readwrite, nonatomic, retain) HVCodableValue* activity;
//
// Optional (a label)
//
@property (readwrite, nonatomic, retain) NSString* title;
//
// (Optional): Distance covered, if any
//
@property (readwrite, nonatomic, retain) HVLengthMeasurement* distance;
//
// (Optional): Duration, if any
//
@property (readwrite, nonatomic, retain) HVPositiveDouble* durationMinutes;
//
// (Optional): Additional details about the exercise
// E.g number of steps, calories burned...
// 
// This collection of Name Value Pairs uses standardized names
// Standardized names should be taken from the vocabulary: exercise-detail-names
//
@property (readwrite, nonatomic, retain) HVNameValueCollection* details;
//
// (Optional): Information about exercise segments
//
@property (readwrite, nonatomic, retain) NSMutableArray* segmentsXml;

//-----------------------------
//
// Convenience properties
//
//-----------------------------
@property (readonly, nonatomic) BOOL hasDetails;
@property (readwrite, nonatomic) double durationMinutesValue;


//-------------------------
//
// Initializers
//
//-------------------------
+(HVItem *) newItem;

-(id) initWithDate:(NSDate *) date;

//-------------------------
//
// Methods
//
//-------------------------
//
// This assumes that the activity is from the standard vocabulary: exercise-activties
//
+(HVCodableValue *) createActivity:(NSString *) activity;
-(BOOL) setStandardActivity:(NSString *) activity;
//
// This assume that the exercise detail is from the standard vocab:exercise-detail-names
// 
-(HVNameValue *) getDetailWithNameCode:(NSString *) name;
-(BOOL) addOrUpdateDetailWithNameCode:(NSString *) name andValue:(HVMeasurement *) value;

//-------------------------
//
// Exercise Details (self.details)
//
//-------------------------
+(HVNameValue *) createDetailWithNameCode:(NSString *) name andValue:(HVMeasurement *) value;

+(BOOL) isDetailForCaloriesBurned:(HVNameValue *) nv;
+(BOOL) isDetailForNumberOfSteps:(HVNameValue *) nv;

//
// Uses VOCABULARIES
//  - exercise-details-names for the detail Name
//  - exercise-units for measurement units
//
+(HVCodableValue *) codeFromUnitsText:(NSString *) unitsText andUnitsCode:(NSString *) unitsCode;
+(HVCodableValue *) unitsCodeForCount;
+(HVCodableValue *) unitsCodeForCalories;

+(HVMeasurement *) measurementFor:(double) value unitsText:(NSString *) unitsText unitsCode:(NSString *) unitsCode;
+(HVMeasurement *) measurementForCount:(double) value;
+(HVMeasurement *) measurementForCalories:(double) value;

+(HVCodedValue *) detailNameWithCode:(NSString *) code;
+(HVCodedValue *) detailNameForSteps;
+(HVCodedValue *) detailNameForCaloriesBurned;

//-------------------------
//
// Vocabs
//
//-------------------------
+(HVVocabIdentifier *) vocabForActivities;
+(HVVocabIdentifier *) vocabForDetails;
+(HVVocabIdentifier *) vocabForUnits;


//-------------------------
//
// Type Information
//
//-------------------------

+(NSString *) typeID;
+(NSString *) XRootElement;

@end

