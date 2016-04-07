//
//  SettingViewController.m
//  pieceSample
//
//  Created by OhnumaRina on 2016/04/07.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.linePayStr.text = @"LinePay決済";
    self.linePayStr.font = [UIFont fontWithName:@"AppleGothic" size:20];
    //    self.linePayStr.backgroundColor = [UIColor yellowColor];
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    NSInteger switchStatus = [userData integerForKey:@"LINEPAY"];
    
    //self.SwitchLinePay = [[UISwitch alloc]init];
    self.linePayStr = [[UILabel alloc]init];
    self.linePayStr.frame = CGRectMake(self.view.bounds.size.width *0.1, self.view.bounds.size.height*0.3, 100, 100);
    
    
    if(switchStatus == 1){
        self.SwitchLinePay.on = YES;
        self.linePayStr.textColor = [UIColor blackColor];
    }else if(switchStatus == 0){
        self.SwitchLinePay.on = NO;
        self.linePayStr.textColor = [UIColor grayColor];
    }else{
        self.SwitchLinePay.on = NO;
        NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
        [defaults setObject:@"0" forKey:@"LINEPAY"];
        [userData registerDefaults:defaults];
    }
    
    [self.view addSubview:self.SwitchLinePay];
    [self.view addSubview:self.linePayStr];
    
    //スイッチ状態判定
    if(self.SwitchLinePay.on == YES){
        self.linePayStr.textColor = [UIColor blackColor];
        NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
        [userData setInteger:1 forKey:@"LINEPAY"];
        [userData synchronize];
    }else{
        self.linePayStr.textColor = [UIColor grayColor];
        NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
        [userData setInteger:0 forKey:@"LINEPAY"];
        [userData synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)switchValueChanged:(id)sender{
    //スイッチオンオフ変更時の処理
    if(self.SwitchLinePay.on == YES){
        self.linePayStr.textColor = [UIColor blackColor];
        NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
        [userData setInteger:1 forKey:@"LINEPAY"];
        [userData synchronize];
    }else{
        self.linePayStr.textColor = [UIColor grayColor];
        NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
        [userData setInteger:0 forKey:@"LINEPAY"];
        [userData synchronize];
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
