//
//  HVInstance.h
//  HVLib
//
//
//
//

#import "HVType.h"

@interface HVInstance : HVType
{
@private
    NSString* m_id;
    NSString* m_name;
    NSString* m_description;
    NSString* m_platformUrl;
    NSString* m_shellUrl;
}

@property (readwrite, nonatomic, retain) NSString* instanceID;
@property (readwrite, nonatomic, retain) NSString* name;
@property (readwrite, nonatomic, retain) NSString* instanceDescription;
@property (readwrite, nonatomic, retain) NSString* platformUrl;
@property (readwrite, nonatomic, retain) NSString* shellUrl;

@end

@interface HVInstanceCollection : HVCollection

-(HVInstance *) indexOfInstance:(NSUInteger) index;

-(NSInteger) indexOfInstanceNamed:(NSString *) name;
-(NSInteger) indexOfInstanceWithID:(NSString *) instanceID;

@end
