//
//  AKTouchIDManager.h
//  sample
//
//  Created by RAHUL'S MAC MINI on 22/12/16.
//  Copyright © 2016 RAHUL'S MAC MINI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
@interface AKTouchIDManager : NSObject
@property(nonatomic) BOOL isTouchIDAvailable;
+ (id)sharedManager;
-(void)evaluateTouchIDAuth:(void(^)(BOOL success))onSuccessAuth andonError:(void(^)(NSError *error))onErrorAuth andOnFailed:(void(^)(NSError *failed))onFailed;
@end
