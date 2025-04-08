//
//  HVCore.m
//  HVLib
//
//

#import "HVCore.h"
#import "HVValidator.h"

NSRange HVMakeRange(NSUInteger i)
{
    return NSMakeRange(i, 1);
}

NSRange HVEmptyRange(void)
{
    return NSMakeRange(0, 0);
}

double roundToPrecision(double value, NSInteger precision)
{
    double places;
    
    // Optimize the common case
    switch (precision) {
        case 0:
            places = 1;
            break;
        case 1:
            places = 10;
            break;
        case 2:
            places = 100;
            break;
        case 3:
            places = 1000;
            break;
        default:
            places = pow(10, precision);
            break;
    }
    return round(value * places) / places;
}

double mgDLToMmolPerL(double mgDLValue, double molarWeight)
{
    //
    // DL = 0.1 Liters
    // (10 * mgDL)/1000 = g/L
    // Molar weight = grams/mole
    //
    // ((10 * mgDL)/1000 / molarWeight) * 1000)
    
    return ((10 * mgDLValue) / molarWeight);
}

double mmolPerLToMgDL(double mmolPerL, double molarWeight)
{
    return (mmolPerL * molarWeight) / 10;
}

id HVClear(id obj)
{
    if (obj)
    {
        [obj release];
    }
    return nil;
}

id HVAssign(id original, id newObj)
{
    [original release];
    return newObj;
}

void HVSetVar(id* var, id value)
{
    if (*var)
    {
        [(*var) release];
        *var = nil;
    }
    *var = [value retain];
}

void HVSetVarIfNotNil(id *var, id value)
{
    if (value)
    {
        HVSetVar(var, value);
    }
}

CFTypeRef HVReplaceRef(CFTypeRef cf, CFTypeRef newRef)
{
    HVReleaseRef(cf);
    return HVRetainRef(newRef);
}

CFTypeRef HVRetainRef(CFTypeRef cf)
{
    if (cf)
    {
        CFRetain(cf);
    }
    
    return cf;
}

void HVReleaseRef(CFTypeRef cf)
{
    if (cf)
    {
        CFRelease(cf);
    }
}

@implementation NSObject (HVExtensions)

-(void) safeInvoke:(SEL)sel
{
    if ([self respondsToSelector:sel])
    {
        @try 
        {
            [self performSelector:sel];
        }
        @catch (id ex) 
        {
            [ex log];
        }
        
    }     
}

-(void) safeInvoke:(SEL)sel withParam:(id)param
{
    if ([self respondsToSelector:sel])
    {
        @try 
        {
            [self performSelector:sel withObject:param];
        }
        @catch (id ex) 
        {
            [ex log];
        }
    } 
}

-(void)invokeOnMainThread:(SEL)aSelector
{
    [self performSelectorOnMainThread:aSelector withObject:nil waitUntilDone:FALSE];
}

-(void)invokeOnMainThread:(SEL)aSelector withObject:(id)obj
{
    [self performSelectorOnMainThread:aSelector withObject:obj waitUntilDone:FALSE];    
}

-(void)log
{
    @try
    {
        HVLogEvent([self descriptionForLog]);
    }
    @catch (id ex) 
    {
        
    }
}

-(NSString *)descriptionForLog
{
    if ([self respondsToSelector:@selector(detailedDescription)])
    {
        return [self performSelector:@selector(detailedDescription)];
    }
    else if ([self respondsToSelector:@selector(description)])
    {
        return [self description];
    }
    else 
    {
        return NSStringFromClass([self class]);
    }    
}

@end

@implementation NSNotificationCenter (HVExtensions)

-(void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name
{
    // Listen to broadcasts
    [self addObserver:observer selector:selector name:name object:nil];
}

-(void) postNotificationName:(NSString *)notification sender:(id)sender argName:(NSString *)name argValue:(id)value
{
    NSMutableDictionary* args = [[NSMutableDictionary alloc] initWithCapacity:1];
    [args setObject:value forKey:name];
    
    [self postNotificationName:notification object:sender userInfo:args];
    
    [args release];
}

-(void)postNotificationName:(NSString *)notification sender:(id)sender argName:(NSString *)n1 argValue:(id)v1 argName:(NSString *)n2 argValue:(id)v2
{
    NSMutableDictionary* args = [[NSMutableDictionary alloc] initWithCapacity:1];
    [args setObject:v1 forKey:n1];
    [args setObject:v2 forKey:n2];
    
    [self postNotificationName:notification object:sender userInfo:args];
    
    [args release];
    
}

@end
