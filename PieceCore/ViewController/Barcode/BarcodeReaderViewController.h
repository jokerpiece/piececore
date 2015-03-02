//
//  BarcodeReaderViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/22.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ItemListViewController.h"
#import "BaseViewController.h"

@protocol BarcodeModalDelegate <NSObject>
-(void)closeBarcodeView:(NSString *)barcodeNum;
@end

@interface BarcodeReaderViewController : BaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) NSString *barcodeNum;
@property (nonatomic) bool isReaded;

@end
