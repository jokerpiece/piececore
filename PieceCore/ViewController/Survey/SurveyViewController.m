//
//  SurveyViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/02.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SurveyViewController.h"

@interface SurveyViewController ()

@end

@implementation SurveyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppearLogic
{
    self.isResponse = NO;
    [self syncAction];
}

-(void)close:(NSTimer*)timer{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate closeSurveyView];
}
-(void)createBtnWithTitle:(NSString *)title tag:(int)tag frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frame;
    btn.tag = tag;
    btn.backgroundColor = [UIColor colorWithRed:0.27 green:0.51 blue:0.71 alpha:1.0];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushAction:)
        forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}
-(void)pushAction:(UIButton *)sender{
    if (!self.isResponse) {
        return;
    }
    self.isResponse = NO;

    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [param setValue:self.data.survey_id forKey:@"survey_id"];
    [param setValue:[NSString stringWithFormat:@"%d",(int)sender.tag] forKey:@"answer_num"];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [conecter sendActionSendId:SendIdSendSurvey param:param];
}

-(void)syncAction{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [conecter sendActionSendId:SendIdGetSurvey param:param];
}


-(void)setData:(SurveyConnector *)data sendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdGetSurvey]) {
        self.data = data;
        self.questionLbl.text = self.data.text;
        [self.questionLbl sizeToFit];
        
        if (self.data.answer_1.length > 0) {
            [self createBtnWithTitle:self.data.answer_1 tag:1 frame:CGRectMake(10, 270, 300, 50)];
        }
        if (self.data.answer_2.length > 0) {
            [self createBtnWithTitle:self.data.answer_2 tag:2 frame:CGRectMake(10, 330, 300, 50)];
        }
        if (self.data.answer_3.length > 0) {
            [self createBtnWithTitle:self.data.answer_3 tag:3 frame:CGRectMake(10, 390, 300, 50)];
        }
    } else {
        for(UIView* view in self.view.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                [view removeFromSuperview];
            }
            
        }
        self.titleLbl.text = @"ありがとうございました！";
        self.descriptionLbl.text = @"今後のサービス向上のため、\nお客様の回答を参考にさせて頂きます。";
        self.questionLbl.text = @"";
        [NSTimer scheduledTimerWithTimeInterval:3.5f target:self selector:@selector(close:) userInfo:nil repeats:NO];
    }
}

-(BaseConnector *)getDataWithSendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdGetSurvey]) {
        return [SurveyConnector alloc];
    } else {
        return [BaseConnector alloc];
    }
}

@end
