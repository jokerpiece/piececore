//
//  TWActivity.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/13.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//



#import "TWActivity.h"

@interface TWActivity ()
@property (nonatomic) UIView *view;
@end
@implementation TWActivity

- (id) initWithView:(UIView *)view {
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle
{
    return @"Twitter";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"Twitter"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL:activityItem]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                    message:@"Twitterがログイン状態でありません。\niphoneの設定＞Twitterよりサインインして下さい。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)performActivity
{
    
}
@end