//
//  AuthenticationCheckState.m
//  CHBase Mobile Library for iOS
//
//

#import "AuthenticationCheckState.h"
#import "HealthVaultService.h"


@implementation AuthenticationCheckState

@synthesize service = _service;
@synthesize target = _target;
@synthesize authCompletedCallBack = _authCompletedCallBack;
@synthesize shellAuthRequiredCallBack = _shellAuthRequiredCallBack;

- (id)initWithService: (HealthVaultService *)service target: (NSObject *)target
                                      authCompletedCallBack: (SEL)authCallBack
                                   shellAuthRequiredCallBack: (SEL)authRequiredCallBack {

    if (self = [super init]) {

        self.service = service;
        self.target = target;
        self.authCompletedCallBack = authCallBack;
        self.shellAuthRequiredCallBack = authRequiredCallBack;
    }

    return self;
}

- (void)dealloc {

    self.service = nil;
    self.target = nil;

    [super dealloc];
}

@end
