//
//  AlertView.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/13.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : NSObject
typedef void(^AlertResponse)(int returnType);

- (id) initWithView:(UIViewController *)vc ;
-(void)showAlertWithTitle:(NSString*)title
                  message:(NSString *) message
             btnTitleList:(NSArray*)btnTitleList
            alertResponse:(AlertResponse)response;
@end
