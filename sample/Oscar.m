//
//  Oscar.m
//  sample
//
//  Created by RAHUL'S MAC MINI on 22/12/16.
//  Copyright © 2016 RAHUL'S MAC MINI. All rights reserved.
//

#import "Oscar.h"

@implementation Oscar

-(void)showScreen{
    UIView *topView = [self _keyWindowView];
    UIView *blurView = [[UIView alloc]initWithFrame:topView.frame];
    [blurView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.5f]];
    [topView addSubview:blurView];
    UIButton *butt = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 100, 50)];
    [butt setTitle:@"TETST" forState:UIControlStateNormal];
    [topView addSubview:butt];

}
- (UIView *)_keyWindowView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows firstObject];
    }
    [window makeKeyWindow];
    return window;
}
@end
