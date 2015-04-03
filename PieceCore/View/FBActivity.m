//
//  FBActivity.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/13.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "FBActivity.h"

@interface FBActivity ()
@property (nonatomic) UIView *view;
@end
@implementation FBActivity

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
    return @"Facebook";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"FB.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
//    for (id activityItem in activityItems) {
//        if ([activityItem isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL:activityItem]) {
//            return YES;
//        }
//    }
    
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                    message:@"FaceBookがログイン状態でありません。\niphoneの設定＞FaceBookよりサインインして下さい。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)performActivity
{
    
}
@end
