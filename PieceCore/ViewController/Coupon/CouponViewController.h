//
//  CouponViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/26.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//
#import "BaseViewController.h"
#import "CouponRecipient.h"
#import "ItemListViewController.h"
typedef enum {
    getCoupon = 0,
    useCoupon
} couponMode;

@interface CouponViewController : BaseViewController<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic) couponMode mode;
@property (strong, nonatomic) UIButton *chengeCoupnTypeBtn;
- (IBAction)changeCoupnTypeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *baseScroll;
@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic)UIPageControl *page;
@property (nonatomic) int pageSize;
@property (strong, nonatomic) CouponRecipient *couponRecipient;
@property (nonatomic) int getPage;
@property (nonatomic,strong) NSString *couponId;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (nonatomic) int getCoupnBtnRactHeight;
@property (nonatomic) bool isDispGetBtn;
-(void)createSlider;
-(void)setCouponNum;
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle isDispGetBtn:(bool)isDispGetBtn;
@end
