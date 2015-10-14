//
//  HVOneToFive.m
//  HVLib
//
//

#import "HVOneToFive.h"

NSString* stringFromRating(enum HVRelativeRating rating)
{
    switch (rating) {
        case HVRelativeRating_VeryLow:
            return @"Very Low";
        
        case HVRelativeRating_Low:
            return @"Low";
        
        case HVRelativeRating_Moderate:
            return @"Moderate";
            
        case HVRelativeRating_High:
            return @"High";
            
        case HVRelativeRating_VeryHigh:
            return @"Very High";
            
        default:
            break;
    }
    
    return c_emptyString;
}

NSString* stringFromNormalcy(enum HVNormalcyRating rating)
{
    switch (rating) {
        case HVNormalcy_WellAboveNormal:
            return @"Well Below Normal";
        
        case HVNormalcy_BelowNormal:
            return @"Below Normal";
        
        case HVNormalcy_Normal:
            return @"Normal";
        
        case HVNormalcy_AboveNormal:
            return @"Above Normal";
        
        case HVNormalcy_WellBelowNormal:
            return @"Well Above Normal";
            
        default:
            break;
    }
    
    return c_emptyString;
}

@implementation HVOneToFive

-(int) min
{
    return 1;
}
-(int) max
{
    return 5;
}

@end
