//
//  DLog.h
//  testPiece
//
//  Created by ハマモト  on 2015/02/13.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#ifndef DLog_h
#define DLog_h

#ifndef __IPHONE_5_0
#warning "This project uses features only available in iOS SDK 5.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG alarm
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif
