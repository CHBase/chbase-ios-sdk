//
//  HVLocalVocabStore.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"
#import "HVVocab.h"
#import "HVGetVocabTask.h"

//-------------------------
//
// Local Cache of HealthVault vocabularies
//
//-------------------------
@interface HVLocalVocabStore : NSObject
{
@private
    id<HVObjectStore> m_objectStore;
}

@property (readonly, nonatomic) id<HVObjectStore> store;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithObjectStore:(id<HVObjectStore>) store;

//-------------------------
//
// Methods
//
//-------------------------

-(BOOL) containsVocabWithID:(HVVocabIdentifier *) vocabID;
-(HVVocabCodeSet *) getVocabWithID:(HVVocabIdentifier *) vocabID;
-(BOOL) putVocab:(HVVocabCodeSet *) vocab withID:(HVVocabIdentifier *) vocabID;
-(void) removeVocabWithID:(HVVocabIdentifier *) vocabID;

//------------
//
// Download Support
//
//------------
// Download the given vocab and save it in the LocalVault
// Use [[HVClient current].localVault getVocab] to load it subsequently
//
-(HVTask *) downloadVocab:(HVVocabIdentifier *) vocab withCallback:(HVTaskCompletion) callback;
-(HVTask *) downloadVocabs:(HVVocabIdentifierCollection *) vocabIDs withCallback:(HVTaskCompletion) callback;

-(void) ensureVocabDownloaded:(HVVocabIdentifier *) vocab; // default - will check for new vocabs once a month
-(void) ensureVocabDownloaded:(HVVocabIdentifier *) vocab maxAge:(NSTimeInterval) ageInSeconds;
-(BOOL) ensureVocabsDownloaded:(HVVocabIdentifierCollection *) vocabIDs maxAge:(NSTimeInterval) ageInSeconds;

//
// Convenience Lookup of codes
//
-(HVVocabItem *) getVocabItemForCode:(NSString *) code inVocab:(HVVocabIdentifier *) vocabID;
-(NSString *) getDisplayTextForCode:(NSString *) code inVocab:(HVVocabIdentifier *) vocabID;

@end
