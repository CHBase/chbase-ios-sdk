//
//  HVOneToFive.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVConstrainedInt.h"

enum HVRelativeRating 
{
    HVRelativeRating_None = 0,
    HVRelativeRating_VeryLow,
    HVRelativeRating_Low,
    HVRelativeRating_Moderate,
    HVRelativeRating_High,
    HVRelativeRating_VeryHigh
};

NSString* stringFromRating(enum HVRelativeRating rating);

enum HVNormalcyRating
{
    HVNormalcy_Unknown = 0,
    HVNormalcy_WellBelowNormal,
    HVNormalcy_BelowNormal,
    HVNormalcy_Normal,
    HVNormalcy_AboveNormal,
    HVNormalcy_WellAboveNormal
};

NSString* stringFromNormalcy(enum HVNormalcyRating rating);


@interface HVOneToFive : HVConstrainedInt

@end

