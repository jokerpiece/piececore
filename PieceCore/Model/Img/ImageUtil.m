//
//  ImageUtil.m
//  TenichiApp
//
//  Created by ハマモト  on 2014/08/21.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil
- (UIImage*)imageByShrinkingWithSize:(CGSize)size uiImage:(UIImage *)image maginW:(int)maginW maginH:(int)maginH
{
    CGFloat widthRatio  = size.width  / image.size.width;
    CGFloat heightRatio = size.height / image.size.height;
    
    CGFloat ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio;
    
    if (ratio >= 1.0) {
        return image;
    }
    
    CGRect rect = CGRectMake(maginW, maginH,
                             image.size.width  * ratio,
                             image.size.height * ratio);
    
    UIGraphicsBeginImageContext(rect.size);
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    
    UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return shrinkedImage;
}

-(void)setRequestWithRequestData:(NSMutableURLRequest *)request img:(UIImage *)img ContentDisposition:(NSString *)disposition{
    if (DEBUG) {
        NSLog(@"画像サイズ　横：%f　縦：%f",img.size.width,img.size.height);
    }
	NSData *imageData = [[NSData alloc]initWithData:UIImageJPEGRepresentation(img, 0.5)];
	
	// 送信データの境界
	NSString *boundary = @"1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	// アップロードする際のパラメーター名とファイル名
	NSString *uploadName = @"file";
	NSString *uploadFileName = @"photo";
	// 送信するデータ（前半）
	NSMutableString *sendDataStringPrev = [NSMutableString stringWithString:@"--"];
	[sendDataStringPrev appendString:boundary];
	[sendDataStringPrev appendString:@"\r\n"];
	[sendDataStringPrev appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n",uploadName,uploadFileName]];
	[sendDataStringPrev appendString:@"Content-Type: image/jpeg\r\n\r\n"];
    
	// 送信するデータ（後半）
	NSMutableString *sendDataStringNext = [NSMutableString stringWithString:@"\r\n"];
	[sendDataStringNext appendString:@"--"];
	[sendDataStringNext appendString:boundary];
	[sendDataStringNext appendString:@"--"];
    
	if (DEBUG) {
        NSLog(@"sendDataStringPrev:%@",sendDataStringPrev);
        NSLog(@"imageData:%d",imageData.length);
        NSLog(@"sendDataStringNext:%@",sendDataStringNext);
    }
	// 送信データの生成
	NSMutableData *sendData = [NSMutableData data];
	[sendData appendData:[sendDataStringPrev dataUsingEncoding:NSUTF8StringEncoding]];
	[sendData appendData:imageData];
	[sendData appendData:[sendDataStringNext dataUsingEncoding:NSUTF8StringEncoding]];
	
	// リクエストヘッダー
	NSDictionary *requestHeader = [NSDictionary dictionaryWithObjectsAndKeys:
								   [NSString stringWithFormat:@"%d",[sendData length]],@"Content-Length",
								   [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary],@"Content-Type",nil];
    [request setAllHTTPHeaderFields:requestHeader];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:sendData];
}

@end
