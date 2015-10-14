//
//  HealthVaultRecord.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>

/// Stores the summary information associated with a record.
@interface HealthVaultRecord : NSObject {

	NSString *_xml;

	NSString *_personId;
	NSString *_personName;

	NSString *_recordId;
	NSString *_recordName;
    NSString *_relationship;
    NSString *_displayName;
    
	NSString *_authStatus;
}

/// Gets or sets the full XML description of this record...
@property (retain) NSString *xml;

/// Gets or sets the person id of the person who has access to this record.
@property (retain) NSString *personId;

/// Gets or sets the name of the person who has access to this record.
@property (retain) NSString *personName;

/// Gets or sets the record id of this record.
@property (retain) NSString *recordId;

/// Gets or sets the name of this record.
@property (retain) NSString *recordName;

@property (retain) NSString *relationship;

@property (retain) NSString *displayName;

/// Gets or sets the authorization status.
@property (retain) NSString *authStatus;

/// Gets whether or not record is valid.
/// Record could be invalid according to some parameters, 
/// like 'app-record-auth-action' != 'NoActionRequired'
@property (readonly, getter = getIsValid) BOOL isValid;

/// Creates a new instance of the HealthVaultRecord class.
/// @param xml - the full XML describing this record.
/// @param personId - the  id of the person.
/// @param personName - the name of the person. 
/// @returns a HealthVaultRecord class instance or nil if xml is not well formed 
/// or record is invalid( see isValid property for more details)
+ (id)newFromXml: (NSString *)xml
		personId: (NSString *)personId
	  personName: (NSString *)personName;

/// Initializes a new instance of the HealthVaultRecord class.
/// @param xml - the full XML describing this record.
/// @param personId - the  id of the person.
/// @param personName - the name of the person. 
- (id)initWithXml: (NSString *)xml
		 personId: (NSString *)personId
	   personName: (NSString *)personName;

@end
