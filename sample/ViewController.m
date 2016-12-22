//
//  ViewController.m
//  sample
//
//  Created by RAHUL'S MAC MINI on 22/12/16.
//  Copyright © 2016 RAHUL'S MAC MINI. All rights reserved.
//

#import "ViewController.h"
#import "Oscar.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
@interface ViewController ()
{
    Oscar *odr;
}@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    odr =[[Oscar alloc]init];
//    [odr showScreen];
    
//    [self Authenticate];
//    [self addKeyChain];
//    [self updateKeyChain];
    [self obtainData];
}


-(void)addKeyChain{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.naga.sample"];
    /*[UICKeyChainStore keyChainStoreWithService:@"com.naga.sample" accessGroup:@"com.naga"];*/
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [keychain setAccessibility:UICKeyChainStoreAccessibilityWhenPasscodeSetThisDeviceOnly
              authenticationPolicy:UICKeyChainStoreAuthenticationPolicyUserPresence];
        keychain[@"kishikawakatsumiw"] = @"01234567-89ab-cdef-0123-45w6789abcdef";
    });
}
-(void)updateKeyChain{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.naga.sample"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [keychain setAccessibility:UICKeyChainStoreAccessibilityWhenPasscodeSetThisDeviceOnly
              authenticationPolicy:UICKeyChainStoreAuthenticationPolicyUserPresence];
        keychain.authenticationPrompt = @"Authenticate to update your access token";
        
        keychain[@"kishikawakatsumiw"] = @"01234567-89ab-cdef-0123-456789abcdef";
    });
}
-(void)obtainData{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.naga.sample"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [keychain setAccessibility:UICKeyChainStoreAccessibilityWhenPasscodeSetThisDeviceOnly
              authenticationPolicy:UICKeyChainStoreAuthenticationPolicyUserPresence];
        keychain.authenticationPrompt = @"Authenticate to update your access token";
        
        NSString *token = keychain[@"kishikawakatsumiw"];
        NSLog(@"%@",token);
    });
}
-(void)removedata{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.naga.sample"];
    keychain[@"kishikawakatsumi"] = nil;
}

-(void)Authenticate{
    [[AKTouchIDManager sharedManager]evaluateTouchIDAuth:^(BOOL success) {
        [self showAlert:@"Suceess!"];
    } andonError:^(NSError *error) {
        [self showAlert:(NSString *)[error localizedDescription]];
    } andOnFailed:^(NSError *failed) {
        [self showAlert:(NSString *)[failed localizedDescription]];
        if ([[AKTouchIDManager sharedManager] isTouchIDAvailable]) {
            [self Authenticate];
        }
    }];
}

-(void)showAlert:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Touch ID" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:true completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
