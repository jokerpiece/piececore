//
//  GetPointView.h
//  piece
//
//  Created by ハマモト  on 2014/10/10.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetPointView : UIView
@property (nonatomic) float titleSize;
@property (nonatomic) float messageSize;
- (id)initWithFrame:(CGRect)frame point:(NSString *)point;
- (id)initWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message titleSize:(float)titleSize messageSize:(float)messageSize;
@end
