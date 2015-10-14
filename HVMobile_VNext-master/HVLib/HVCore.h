//
//  HVCore.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#define IsNsNull(var) (var == [NSNull null])

NSRange HVMakeRange(NSUInteger i);
NSRange HVEmptyRange(void);

double roundToPrecision(double value, NSInteger precision);
double mgDLToMmolPerL(double mgDLValue, double molarWeight);
double mmolPerLToMgDL(double mmolPerL, double molarWeight);

//--------------------------------------
//
// MEMORY MANAGEMENT 
// 
//--------------------------------------
#define HVALLOC_FAIL return HVClear(self)

#define HVENSURE(var, className)    if (!var) { var = [[className alloc] init];  } 
                                    
#define HVASSIGN(var, newVar)   var = HVAssign(var, newVar)
#define HVRETAIN(var, newVar)   HVSetVar(&var, newVar)
#define HVCLEAR(var) var = HVClear(var)
#define HVSET(var, value) HVSetVar(&var, value)
#define HVSETIF(var, value) HVSetVarIfNotNil(&var, value)


id HVClear(id obj);
id HVAssign(id original, id newObj);
void HVSetVar(id* var, id value);
void HVSetVarIfNotNil(id* var, id value);

CFTypeRef HVReplaceRef(CFTypeRef ref, CFTypeRef newRef);
CFTypeRef HVRetainRef(CFTypeRef cf);
void HVReleaseRef(CFTypeRef cf);

//--------------------------------------
//
// Standard NSObject Extensions 
//
//--------------------------------------
@interface NSObject (HVExtensions)

-(void) safeInvoke:(SEL) sel;
-(void) safeInvoke:(SEL) sel withParam:(id) param;

-(void) invokeOnMainThread:(SEL)aSelector;
-(void) invokeOnMainThread:(SEL)aSelector withObject:(id) obj;

-(void) log;
-(NSString *) descriptionForLog;

@end

//------------------------------------
//
// Notifications
//
//------------------------------------
#define HVDECLARE_NOTIFICATION(var) extern NSString* const var;
#define HVDEFINE_NOTIFICATION(var) NSString* const var = @#var;

@interface NSNotificationCenter (HVExtensions)

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name;

-(void)postNotificationName:(NSString *)notification sender:(id) sender argName:(NSString *) name argValue:(id) value;
-(void)postNotificationName:(NSString *)notification sender:(id) sender argName:(NSString *) n1 argValue:(id) v1 argName:(NSString *) n2 argValue:(id) v2;

@end
