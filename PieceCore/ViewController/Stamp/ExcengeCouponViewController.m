//
//  ExcengeCouponViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/11.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ExcengeCouponViewController.h"

@interface ExcengeCouponViewController ()

@end

@implementation ExcengeCouponViewController


-(void)syncAction{
    self.isResponse = NO;
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSString *sendId = @"";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.mode == useCoupon) {
        sendId = SendIdCouponTake;
        [param setValue:[Common getUuid] forKey:@"uuid"];
    } else {
        NSString *strExType = @"0";
        if (self.exType == point) {
            strExType = @"1";
        } else if (self.exType == stamp) {
            strExType = @"2";
        }
//        sendId = SendIdCouponExchange;
        sendId = SendIdCouponGive;
        [param setValue:[Common getUuid] forKey:@"uuid"];
        [param setValue:strExType forKey:@"coupon_type"];
        [param setValue:[Common getUuid] forKey:@"stamp_id"];
    }
    [conecter sendActionSendId:sendId param:param];
    
}

//-(void)setData:(CouponConnector *)data sendId:(NSString *)sendId{
//    
//    if ([sendId isEqualToString:SendIdGetCoupon]) {
//    } else if([sendId isEqualToString:SendIdItemCoupon]){
//        
//        if ([PieceCoreConfig tabnumberShopping]) {
//            ItemConnector *data = (ItemConnector *)data;
//            
//            UINavigationController *vc = self.tabBarController.viewControllers[[PieceCoreConfig tabnumberShopping].intValue];
//            self.tabBarController.selectedViewController = vc;
//            [vc popToRootViewControllerAnimated:NO];
//            
//            CouponData *couponModel = [self.data.list objectAtIndex:self.getPage];
//            
//            UIPasteboard *board = [UIPasteboard generalPasteboard];
//            [board setValue:[NSString stringWithFormat:@"%@",couponModel.coupon_code] forPasteboardType:@"public.utf8-plain-text"];
//            [super showAlert:@"確認" message:@"クーポン番号をコピーしました。\n購入画面でクーポン番号入力欄にペーストして下さい。"];
//            
//            if (data.list.count != 0) {
//                
//                [vc.viewControllers[0] performSegueWithIdentifier:@"toItem" sender:nil];
//                ItemListViewController * controller = vc.viewControllers[1];
//                controller.isNext = YES;
//                
//                controller.searchType = coupon;
//                controller.code = couponModel.coupon_id;
//            }
//        }
//        
//    } else{
//        self.data = data;
//        [self createSlider];
//        CGRect frame = self.scroll.frame;
//        frame.origin.x = frame.size.width * self.page.currentPage;
//        [self.scroll scrollRectToVisible:frame animated:YES];
//    }
//    
//}
//
//-(BaseConnector *)getDataWithSendId:(NSString *)sendId{
//    if ([sendId isEqualToString:SendIdGetCoupon]) {
//        return [BaseConnector alloc];
//    } else if ([sendId isEqualToString:SendIdItemCoupon]) {
//        return [ItemConnector alloc];
//    } else {
//        return [CouponConnector alloc];
//    }
//}
@end
