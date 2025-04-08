//
//  HVSearchVocabTask.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVocabSearchTask.h"

static NSString* const c_element_vocab = @"vocabulary-key";
static NSString* const c_element_params = @"text-search-parameters";

@implementation HVVocabSearchTask

@synthesize vocabID = m_vocabID;
@synthesize params = m_params;

-(NSString *)name
{
    return @"SearchVocabulary";
}

-(float)version
{
    return 1;
}

-(HVVocabCodeSet *)searchResult
{
    HVVocabSearchResults* results = (HVVocabSearchResults *) self.result;
    return results.hasMatches ? results.match : nil;
}

-(id)initWithVocab:(HVVocabIdentifier *)vocab searchText:(NSString *)text andCallback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(vocab);
    
    self = [super initWithCallback:callback];
    HVCHECK_SELF;
    
    self.vocabID = vocab;
    
    m_params = [[HVVocabSearchParams alloc] initWithText:text];
    HVCHECK_NOTNULL(m_params);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_vocabID release];
    [m_params release];
    [super dealloc];
}

-(void)serializeRequestBodyToWriter:(XWriter *)writer
{
    [self validateObject:m_vocabID];
    [self validateObject:m_params];
    
    [XSerializer serialize:m_vocabID withRoot:c_element_vocab toWriter:writer];
    [XSerializer serialize:m_params withRoot:c_element_params toWriter:writer];
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader
{
    return [super deserializeResponseBodyFromReader:reader asClass:[HVVocabSearchResults class]];
}

+(HVVocabSearchTask *)searchForText:(NSString *)text inVocabFamily:(NSString *)family vocabName:(NSString *)name callback:(HVTaskCompletion)callback
{
    HVVocabIdentifier* vocab = [[HVVocabIdentifier alloc] initWithFamily:family andName:name];
    HVCHECK_NOTNULL(vocab);
    
    HVVocabSearchTask* searchTask = [HVVocabSearchTask searchForText:text inVocab:vocab callback:callback];
    [vocab release];
    
    return searchTask;

LError:
    return nil;
}

+(HVVocabSearchTask *)searchForText:(NSString *)text inVocab:(HVVocabIdentifier *)vocab callback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(vocab);
    
    HVVocabSearchTask* searchTask = [[[HVVocabSearchTask alloc] initWithVocab:vocab searchText:text andCallback:callback] autorelease];
    HVCHECK_NOTNULL(searchTask);
    
    [searchTask start];    
    
    return searchTask;
    
LError:
    return nil;    
}

+(HVVocabSearchTask *)searchMedications:(NSString *)text callback:(HVTaskCompletion)callback
{
    return [HVVocabSearchTask searchForText:text inVocabFamily:@"RxNorm" vocabName:@"RxNorm Active Medicines" callback:callback];
}

@end
