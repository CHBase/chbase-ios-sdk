//
//  HVItemSection.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemSection.h"

NSString* const c_itemsection_core = @"core";
NSString* const c_itemsection_audit = @"audits";
NSString* const c_itemsection_blob = @"blobpayload";
NSString* const c_itemsection_tags = @"tags";
NSString* const c_itemsection_permissions = @"effectivepermissions";
NSString* const c_itemsection_signatures = @"digitalsignatures";

NSString* HVItemSectionToString(enum HVItemSection section)
{
   switch (section) {
        case HVItemSection_Core:
            return c_itemsection_core;
            
        case HVItemSection_Audits:
            return c_itemsection_audit;
            
        case HVItemSection_Blobs:
            return c_itemsection_blob;
            
        case HVItemSection_Tags:
            return c_itemsection_tags;
            
        case HVItemSection_Permissions:
            return c_itemsection_permissions;
            
        case HVItemSection_Signatures:
            return c_itemsection_signatures;
            
        default:
            break;
    }
    
    return nil;
}

enum HVItemSection HVItemSectionFromString(NSString* value)
{
    if ([NSString isNilOrEmpty:value])
    {
        return HVItemSection_None;
    }
    
    enum HVItemSection section = HVItemSection_None;

    if ([value isEqualToString:c_itemsection_core])
    {
        section = HVItemSection_Core;
    }
    else if ([value isEqualToString:c_itemsection_audit])
    {
        section = HVItemSection_Audits;
    }
    else if ([value isEqualToString:c_itemsection_blob])
    {
        section = HVItemSection_Blobs;
    }
    else if ([value isEqualToString:c_itemsection_tags])
    {
        section = HVItemSection_Tags;
    }
    else if ([value isEqualToString:c_itemsection_permissions])
    {
        section = HVItemSection_Permissions;
    }
    else if ([value isEqualToString:c_itemsection_signatures])
    {
        section = HVItemSection_Signatures;
    }

    return section;
}
