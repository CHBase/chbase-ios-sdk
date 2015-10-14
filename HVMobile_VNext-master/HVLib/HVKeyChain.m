//
//  HVKeyChain.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVClient.h"
#import "HVKeyChain.h"

@implementation HVKeyChain

+(NSMutableDictionary *) attributesForPasswordName:(NSString *)passwordName
{
    HVCHECK_STRING(passwordName);
    
    NSMutableDictionary* attrib = [NSMutableDictionary dictionary];
    HVCHECK_NOTNULL(attrib);
    
    [attrib setObject:passwordName forKey:(id)kSecAttrGeneric];
    [attrib setObject:passwordName forKey:(id) kSecAttrAccount];
    [attrib setObject:@"HealthVault" forKey:(id) kSecAttrService];
 
    return attrib;
    
LError:
    return nil;
}

+(NSMutableDictionary *)queryForPasswordName:(NSString *)passwordName
{
    NSMutableDictionary* query = [HVKeyChain attributesForPasswordName:passwordName];
    HVCHECK_NOTNULL(query);
    
    [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    
    return query;
    
LError:
    return nil;
}

+(NSData *)runQuery:(NSMutableDictionary *)query
{
    HVCHECK_NOTNULL(query);
    
    [query setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    
    NSData* data = nil;
    if (SecItemCopyMatching((CFDictionaryRef) query, (CFTypeRef *)&data) == errSecSuccess)
    {
        return data;
    }
    
LError:
    return nil;
}

+(NSData *)getPassword:(NSString *)passwordName
{
    NSMutableDictionary* query = [HVKeyChain queryForPasswordName:passwordName];
    HVCHECK_NOTNULL(query);
    
    return [HVKeyChain runQuery:query];
    
LError:
    return nil;
}

+(NSString *)getPasswordString:(NSString *)passwordName
{
    NSData* password = [HVKeyChain getPassword:passwordName];
    if (!password || password.length == 0)
    {
        return nil;
    }
    
    NSString* string = [[[NSString alloc] initWithData:password encoding:NSUTF8StringEncoding] autorelease];
    [password release];
    return string;
    
LError:
    return nil;
}

+(BOOL)setPassword:(NSString *)password forName:(NSString *)passwordName
{
    if ([NSString isNilOrEmpty:password])
    {
        return [HVKeyChain removePassword:passwordName];
    }
    
    NSMutableDictionary* query = [HVKeyChain queryForPasswordName:passwordName];
    HVCHECK_NOTNULL(query);

    NSData* passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    HVCHECK_NOTNULL(passwordData);

    NSMutableDictionary* update = [HVKeyChain attributesForPasswordName:passwordName];
    HVCHECK_NOTNULL(update);
    
    [update setObject:passwordData forKey:(id)kSecValueData];
    
    OSStatus error = 0;
    if ([self getPasswordString:passwordName] != nil)
    {
        // Update existing
        error = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef) update);
    }
    else
    {
        [update setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];   
        error = SecItemAdd((CFDictionaryRef)update, NULL);
    }
    
    return (error == errSecSuccess);
    
LError:
    return FALSE;
}

+(BOOL)removePassword:(NSString *)passwordName
{
    NSMutableDictionary* query = [HVKeyChain queryForPasswordName:passwordName];
    HVCHECK_NOTNULL(query);
    
    OSStatus error = SecItemDelete((CFDictionaryRef) query);
    
    return (error == errSecSuccess);
    
LError:
    return FALSE;
}

@end
