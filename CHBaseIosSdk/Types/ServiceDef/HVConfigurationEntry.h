//
//  HVConfigurationEntry.h
//  HVLib
//
//
//

#import "HVType.h"
#import "HVCollection.h"

@interface HVConfigurationEntry : HVType
{
@private
    NSString* m_key;
    NSString* m_value;
}

@property (readwrite, nonatomic, retain) NSString* key;
@property (readwrite, nonatomic, retain) NSString* value;

@end

@interface HVConfigurationEntryCollection : HVCollection

@end