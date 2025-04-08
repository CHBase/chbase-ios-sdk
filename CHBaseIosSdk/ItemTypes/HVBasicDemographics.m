//
//  BasicDemographics.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVBasicDemographics.h"

static NSString* const c_gender_female = @"f";
static NSString* const c_gender_male = @"m";

NSString* stringFromGender(enum HVGender gender)
{
    NSString* genderString = nil;
    
    switch (gender) {
        case HVGenderFemale:
            genderString = c_gender_female; 
            break;
        
        case HVGenderMale:
            genderString = c_gender_male;
            break;
            
        default:
            break;
    }
    
    return genderString;
}

enum HVGender stringToGender(NSString* genderString)
{
    if ([genderString isEqualToString:c_gender_female])
    {
        return HVGenderFemale;
    }
    
    if ([genderString isEqualToString:c_gender_male])
    {
        return HVGenderMale;
    }
    
    return HVGenderNone;   
}


static NSString* const c_typeid = @"3b3e6b16-eb69-483c-8d7e-dfe116ae6092";
static NSString* const c_typename = @"basic";

static NSString* const c_element_gender = @"gender";
static NSString* const c_element_birthyear = @"birthyear";
static NSString* const c_element_country = @"country";
static NSString* const c_element_postcode = @"postcode";
static NSString* const c_element_city = @"city";
static NSString* const c_element_state = @"state";
static NSString* const c_element_dow = @"firstdow";
static NSString* const c_element_lang = @"language";

@implementation HVBasicDemographics

@synthesize gender = m_gender;
@synthesize birthYear = m_birthYear;
@synthesize country = m_country;
@synthesize postalCode = m_postalCode;
@synthesize city = m_city;
@synthesize state = m_state;
@synthesize languageXml = m_languageXml;

-(void)dealloc
{
    [m_birthYear release];
    [m_country release];
    [m_postalCode release];
    [m_city release];
    [m_state release];
    [m_firstDOW release];
    [m_languageXml release];
    [super dealloc];
}

-(NSString *)genderAsString
{
    return stringFromGender(m_gender);
}

+(HVVocabIdentifier *)vocabForGender
{
    return [[[HVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"gender-types"] autorelease];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN

    HVVALIDATE_OPTIONAL(m_birthYear);
    HVVALIDATE_OPTIONAL(m_country);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_ENUM(m_gender, c_element_gender, stringFromGender);
    HVSERIALIZE(m_birthYear, c_element_birthyear);
    HVSERIALIZE(m_country, c_element_country);
    HVSERIALIZE_STRING(m_postalCode, c_element_postcode);
    HVSERIALIZE_STRING(m_city, c_element_city);
    HVSERIALIZE(m_state, c_element_state);
    HVSERIALIZE(m_firstDOW, c_element_dow);
    HVSERIALIZE_RAW(m_languageXml);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_ENUM(m_gender, c_element_gender, stringToGender);
    HVDESERIALIZE(m_birthYear, c_element_birthyear, HVYear);
    HVDESERIALIZE(m_country, c_element_country, HVCodableValue);
    HVDESERIALIZE_STRING(m_postalCode, c_element_postcode);
    HVDESERIALIZE_STRING(m_city, c_element_city);
    HVDESERIALIZE(m_state, c_element_state, HVCodableValue);
    HVDESERIALIZE(m_firstDOW, c_element_dow, HVInt);
    HVDESERIALIZE_RAW(m_languageXml, c_element_lang);
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVBasicDemographics typeID]];
}

+(BOOL)isSingletonType
{
    return TRUE;
}

@end
