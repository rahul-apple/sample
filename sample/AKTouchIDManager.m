//
//  AKTouchIDManager.m
//  sample
//
//  Created by RAHUL'S MAC MINI on 22/12/16.
//  Copyright © 2016 RAHUL'S MAC MINI. All rights reserved.
//

#import "AKTouchIDManager.h"

@implementation AKTouchIDManager

#pragma mark Singleton Methods
+ (id)sharedManager {
    static AKTouchIDManager *sharedMyManager = nil;
    static dispatch_once_t onceToken; dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init]; });
    return sharedMyManager;
}
- (id)init {
    if (self = [super init]) {
        [self checkAndUpdateDeviceStatus];
    }
return self;
}
- (void)dealloc { 
    // Should never be called, but just here for clarity really.
}

-(void)checkAndUpdateDeviceStatus{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        self.isTouchIDAvailable = true;
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        self.isTouchIDAvailable = false;
    }
}

-(void)evaluateTouchIDAuth:(void(^)(BOOL success))onSuccessAuth andonError:(void(^)(NSError *error))onErrorAuth andOnFailed:(void(^)(NSError *failed))onFailed{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Unlock access to ";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    onSuccessAuth(success);
                                }else if(error){
                                     onErrorAuth(error);
                                switch (error.code) {
                                    case LAErrorAuthenticationFailed:{
                                        NSLog(@"Authentication Failed");
                                        break;
                                    }
                                    case LAErrorUserCancel:{
                                        NSLog(@"User pressed Cancel button");
                                        break;
                                    }
                                    case LAErrorUserFallback:{
                                        NSLog(@"User pressed \"Enter Password\"");
                                        break;
                                    }
                                    default:{
                                        NSLog(@"Touch ID is not configured");
                                        break;
                                    }
                                }
                            }
                            else {
                                onErrorAuth(error);
                            }
                        }];
    } else {
        onFailed(authError);
    }
}


@end
