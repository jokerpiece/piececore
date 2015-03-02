//
//  SurveyViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/02.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BaseViewController.h"
#import "SurveyConnector.h"
@protocol surveyDelegate <NSObject>
-(void)closeSurveyView;
@end
@interface SurveyViewController : BaseViewController<NetworkDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (nonatomic,weak) id delegate;
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (nonatomic) bool isResponse;
@property (strong, nonatomic) SurveyConnector *data;
@property (weak, nonatomic) IBOutlet UIView *view;
@end
