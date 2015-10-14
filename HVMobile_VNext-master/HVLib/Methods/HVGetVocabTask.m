//
//  HVGetVocab.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVGetVocabTask.h"

static NSString* const c_element_vocab = @"vocabulary";

@implementation HVVocabGetResults

@synthesize vocabs = m_vocabs;

-(HVVocabCodeSet *)firstVocab
{
    return (m_vocabs) ? [m_vocabs itemAtIndex:0] : nil;
}

-(void)dealloc
{
    [m_vocabs release];
    [super dealloc];
}

-(void)serialize:(XWriter *)writer  
{
    HVSERIALIZE_ARRAY(m_vocabs, c_element_vocab);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_vocabs, c_element_vocab, HVVocabCodeSet, HVVocabSetCollection);
}

@end

@implementation HVGetVocabTask

@synthesize params = m_params;

-(NSString *)name
{
    return @"GetVocabulary";
}

-(float)version
{
    return 2;
}

-(HVVocabGetResults *) vocabResults
{
    return (HVVocabGetResults *) self.result;
}

-(HVVocabCodeSet *)vocabulary
{
    HVVocabGetResults* results = self.vocabResults;
    return (results) ? results.firstVocab : nil;
}

-(id)initWithVocabID:(HVVocabIdentifier *)vocabID andCallback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(vocabID);
    
    self = [super initWithCallback:callback];
    HVCHECK_SELF;
    
    m_params = [[HVVocabParams alloc] initWithVocabID:vocabID];
    HVCHECK_NOTNULL(m_params);
        
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_params release];
    [super dealloc];
}

-(void)serializeRequestBodyToWriter:(XWriter *)writer
{
    [self validateObject:m_params];
    [XSerializer serialize:m_params withRoot:@"vocabulary-parameters" toWriter:writer];
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader
{
    return [super deserializeResponseBodyFromReader:reader asClass:[HVVocabGetResults class]];
}

@end
