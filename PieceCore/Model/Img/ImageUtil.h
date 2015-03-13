//
//  ImageUtil.h
//  TenichiApp
//
//  Created by ハマモト  on 2014/08/21.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtil : NSObject
- (UIImage*)imageByShrinkingWithSize:(CGSize)size uiImage:(UIImage *)image maginW:(int)maginW maginH:(int)maginH;
-(void)setRequestWithRequestData:(NSMutableURLRequest *)request img:(UIImage *)img ContentDisposition:(NSString *)disposition;
@end
