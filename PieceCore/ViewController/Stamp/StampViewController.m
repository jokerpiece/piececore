//
//  StampViewController.m
//  piece
//
//  Created by ハマモト  on 2015/02/12.
//  Copyright (c) 2015年 ハマモト . All rights reserved.
//

#import "StampViewController.h"
#import "StampRecipient.h"
#import "RoundView.h"
#import "ExcengeCouponViewController.h"

@interface StampViewController ()
@property (weak, nonatomic) IBOutlet UILabel *startDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *endDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (nonatomic) UIButton *excengeCouponBtn;
@property (weak, nonatomic) IBOutlet RoundView *messageView;

@end

@implementation StampViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"StampViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic
{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].stampTitle;
    }
    self.stampLineStartHeight = self.messageView.frame.origin.y + self.messageView.frame.size.height + 30;
    DLog(@"message %f %f", self.messageView.frame.origin.y,self.messageView.frame.size.height);
    [self syncAction];
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [conecter sendActionSendId:SendIdStamp param:param];
    
    
}
- (void)exchangeCouponAction:(id)sender {
    ExcengeCouponViewController *vc = [[ExcengeCouponViewController alloc] initWithNibName:@"ExcengeCouponViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setDataWithRecipient:(StampRecipient *)recipient sendId:(NSString *)sendId{
    
    //test
    recipient.get_point = @"10";
    recipient.total_point = @"10";
    
    int StampLineCount = ceil(recipient.total_point.intValue/5.0);
    int mod = recipient.total_point.intValue%5;
    int stampCount = 0;

    for (int i = 1; i <= StampLineCount; i++) {
        UIView *stampLineView =[[UIView alloc] initWithFrame:CGRectMake(self.viewSize.width * 0.05, self.stampLineStartHeight + 70*(i -1), self.viewSize.width * 0.9, 30)];
        //stampLineView.backgroundColor = [UIColor grayColor];

        UIImage *stampBarImg = [UIImage imageNamed:@"stampbar.png"];
        UIImageView *stampBariv = [[UIImageView alloc] initWithImage:stampBarImg];
        stampBariv.frame = CGRectMake(0, 0, stampLineView.frame.size.width, 30);
        [stampLineView addSubview:stampBariv];
        
        int stampLimit = 5;
        if (i == StampLineCount && mod != 0) {
            stampLimit = mod;
        }
        for (int ii=0; ii < stampLimit; ii ++) {
            stampCount ++;
            UIImage *stampBaseImg = [UIImage imageNamed:@"stampbase.png"];
            UIImageView *stampBaseIv = [[UIImageView alloc] initWithImage:stampBaseImg];
            stampBaseIv.frame = CGRectMake(60*ii, -10, 50, 50);
            [stampLineView addSubview:stampBaseIv];
            if (stampCount <= recipient.get_point.intValue) {
                UIImage *stampImg = [UIImage imageNamed:@"stamp.png"];
                UIImageView *stampIv = [[UIImageView alloc] initWithImage:stampImg];
                stampIv.frame = CGRectMake(0, 0, 50, 50);
                [stampBaseIv addSubview:stampIv];
                if (stampCount == recipient.get_point.intValue) {
                    stampIv.transform = CGAffineTransformMakeScale(3, 3);
                    [UIView animateWithDuration:1.0f
                                      animations:^{
                                          stampIv.transform = CGAffineTransformMakeScale(1, 1);
                                          
                                      }completion:^(BOOL finished){
                                          self.excengeCouponBtn.alpha = 1.0f;
                                          self.excengeCouponBtn.enabled = YES;
                                      }];
                }
            } else if(stampCount > recipient.get_point.intValue){
                UILabel *countLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0,50,50)];
                countLbl.textAlignment = NSTextAlignmentCenter;
                countLbl.text = [NSString stringWithFormat:@"%d",stampCount];
                countLbl.textColor = [UIColor lightGrayColor];
                [stampBaseIv addSubview:countLbl];
            }
        }
        
        [self.view addSubview:stampLineView];
    }
    
    self.excengeCouponBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.viewSize.width * 0.1, self.stampLineStartHeight + StampLineCount * 70, self.viewSize.width * 0.8, 45)];
    [self.excengeCouponBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.excengeCouponBtn setTitle:@"クーポンと交換" forState:UIControlStateNormal];
    [self.excengeCouponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.excengeCouponBtn.backgroundColor = [UIColor colorWithRed:0.28 green:0.24 blue:0.55 alpha:1.0];
    [self.excengeCouponBtn addTarget:self
            action:@selector(exchangeCouponAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.excengeCouponBtn];
    
    
    self.excengeCouponBtn.enabled = NO;
    self.excengeCouponBtn.alpha = 0;
    
    
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [StampRecipient alloc];
}
@end
