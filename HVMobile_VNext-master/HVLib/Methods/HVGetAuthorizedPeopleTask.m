//
//  HVGetAuthorizedPeople.m
//  HVLib
//
//

#import "HVGetAuthorizedPeopleTask.h"
#import "HVGetAuthorizedPeopleResult.h"

@implementation HVGetAuthorizedPeopleTask

-(NSString *)name
{
    return @"GetAuthorizedPeople";
}

-(float)version
{
    return 1;
}

-(NSArray *)persons
{
    HVGetAuthorizedPeopleResult* result = (HVGetAuthorizedPeopleResult *) self.result;
    return (result) ? result.persons : nil;
}

-(void)serializeRequestBodyToWriter:(XWriter *)writer
{
    [writer writeStartElement:@"parameters"];
    [writer writeEndElement];
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader
{
    return [super deserializeResponseBodyFromReader:reader asClass:[HVGetAuthorizedPeopleResult class]];
}
@end
