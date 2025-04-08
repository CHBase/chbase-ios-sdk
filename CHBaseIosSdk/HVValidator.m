//
//  Validator.m
//  HVLib
//
//

#import "HVValidator.h"
#import "HVStringExtensions.h"
#import "HVExceptionExtensions.h"
#import "HVClientException.h"
#import "HVType.h"

static id<HVEventLog> s_eventLog;

void HVRegisterEventLog(id<HVEventLog> log)
{
    s_eventLog = log;
}

void HVLogEvent(NSString* message)
{
    if (s_eventLog)
    {
        @try 
        {
            [s_eventLog writeMessage:message];
            NSLog(@"%@", message);
        }
        @catch (id exception) 
        {
            
        }
    }
}

void HVLogEventFromCode(NSString* message, const char* fileName, NSUInteger line)
{
    //
    // FileNames can have full paths with embedded names of developers!
    // Remove them before logging. We'll only log the actual file name
    //
    NSString* fileNameString = [NSString stringWithUTF8String:fileName];
    fileNameString = [fileNameString lastPathComponent];
    NSString* logLine = [NSString stringWithFormat:@"%@ file:%@ line:%d", 
                                                message, 
                                                fileNameString, 
                                                line];
    HVLogEvent(logLine);
}

HVClientResult* HVValidateArray(NSArray* array, enum HVClientResultCode error)
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_PTR(array, error);
    
    Class hvClass = [HVType class];
    Class stringClass = [NSString class];
    
    for (id obj in array) 
    {
        HVVALIDATE_PTR(obj, error);
        
        if ([obj isKindOfClass:hvClass])
        {
            HVType* hvType = (HVType *) obj;
            HVCHECK_RESULT([hvType validate]);
        }
        else if ([obj isKindOfClass:stringClass])
        {
            HVVALIDATE_STRING((NSString *) obj, error);
        }
    }
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}