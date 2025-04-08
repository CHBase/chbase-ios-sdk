//
//  HVItemSection.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVCollection.h"

enum HVItemSection 
{
    HVItemSection_None = 0,
    HVItemSection_Data = 0x01,
    HVItemSection_Core = 0x02,
    HVItemSection_Audits = 0x04,
    HVItemSection_Tags = 0x08,          // Not supported by HVItem parsing
    HVItemSection_Blobs = 0x10,
    HVItemSection_Permissions = 0x20,   // Not supported by HVItem parsing
    HVItemSection_Signatures = 0x40,    // Not supported by HVItem parsing
    //
    // Composite
    //
    HVItemSection_Standard = (HVItemSection_Data | HVItemSection_Core)
};

NSString* HVItemSectionToString(enum HVItemSection section);
enum HVItemSection HVItemSectionFromString(NSString *string);
