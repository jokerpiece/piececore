//
//  HomeViewController.h
//  piece
//
//  Created by ハマモト  on 2014/09/10.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//


#import "BaseViewController.h"
#import "FlyerConnector.h"
#import "ItemListViewController.h"
#import "ItemViewController.h"
#import "CategoryViewController.h"
#import "SurveyViewController.h"
#import "InfoConnector.h"

@interface FlyerViewController : BaseViewController<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic)UIPageControl *page;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic) int pageSize;
@property (strong, nonatomic) FlyerConnector *data;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) bool isDispSurvey;
@property (strong, nonatomic) NSString *fliyerId;
@property (nonatomic) float headerHeight;
@property (nonatomic) float pageControllHeight;
@property (nonatomic) float bodyWidh;
- (void)view_Tapped:(UITapGestureRecognizer *)sender;

-(void)createSlider;
@end
