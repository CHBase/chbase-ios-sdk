//
//  HVSystemInstances.h
//  HVLib
//
//
//
//
//

#import "HVType.h"
#import "HVInstance.h"

@interface HVSystemInstances : HVType
{
@private
    NSString* m_currentInstanceID;
    HVInstanceCollection* m_instances;
}

@property (readwrite, nonatomic, retain) NSString* currentInstanceID;
@property (readwrite, nonatomic, retain) HVInstanceCollection* instances;

@end
