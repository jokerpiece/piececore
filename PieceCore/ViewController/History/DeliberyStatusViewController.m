//
//  DeliberyStatusViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/20.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "DeliberyStatusViewController.h"

@interface DeliberyStatusViewController ()

@end

@implementation DeliberyStatusViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"DeliberyStatusViewController" owner:self options:nil];
}


- (void)viewDidLoadLogic {
    [self setSeed];
}

-(void)setSeed{
    self.deliveryInfoList = [NSMutableArray array];
    if (self.delicerStatus != preparation) {
        DeliveryInfoData *data = [[DeliveryInfoData alloc]init];
        data.strDate = @"2014/08/08";
        data.message = @"商品を出荷致しました。";
        data.address = @"大阪府大阪市城東区";
        [self.deliveryInfoList insertObject:data atIndex:0];
    } else{
        return;
    }
    if (self.delicerStatus != sipment) {
        DeliveryInfoData *data = [[DeliveryInfoData alloc]init];
        data.strDate = @"2014/08/09";
        data.message = @"配達センターから荷物を配達中です。";
        data.address = @"大阪府高槻市";
        [self.deliveryInfoList insertObject:data atIndex:0];
    } else{
        return;
    }
    if (self.delicerStatus != deliver) {
        DeliveryInfoData *data = [[DeliveryInfoData alloc]init];
        data.strDate = @"2014/08/10";
        data.message = @"配達が完了しました。";
        data.address = @"大阪府高槻市";
        [self.deliveryInfoList insertObject:data atIndex:0];
    }else{
        return;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        DeliveryInfoData *data = [self.deliveryInfoList objectAtIndex:indexPath.row];
        
        
        UILabel *dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10,10,100,40)];
        dateLbl.text = data.strDate;
        dateLbl.font = [UIFont fontWithName:@"AppleGothic" size:12];
        dateLbl.alpha = 1.0f;
        dateLbl.backgroundColor = [UIColor clearColor];
        dateLbl.textColor = [UIColor grayColor];
        dateLbl.numberOfLines = 1;
        [cell.contentView addSubview:dateLbl];
        
        UILabel *addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(100,10,200,40)];
        addressLbl.text = data.address;
        addressLbl.font = [UIFont fontWithName:@"AppleGothic" size:12];
        addressLbl.alpha = 1.0f;
        addressLbl.backgroundColor = [UIColor clearColor];
        addressLbl.textColor = [UIColor grayColor];
        addressLbl.numberOfLines = 1;
        [cell.contentView addSubview:addressLbl];
        
        UILabel *messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(10,50,300,40)];
        messageLbl.text = data.message;
        messageLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
        messageLbl.alpha = 1.0f;
        messageLbl.backgroundColor = [UIColor clearColor];
        messageLbl.numberOfLines = 2;
        [cell.contentView addSubview:messageLbl];
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
            UIImageView *reloadView = [[UIImageView alloc] init];
            reloadView.frame = CGRectMake(80,15, 32, 32);
            reloadView.image = [UIImage imageNamed:@"undo.png"];
            [cell.contentView addSubview:reloadView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125,20,100,25)];
            label.text = @"次を検索する";
            label.font = [UIFont fontWithName:@"AppleGothic" size:16];
            label.alpha = 1.0f;
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
        }
        return cell;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100.0f;
    } else {
        return 60.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.deliveryInfoList.count;
    }
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"toDeliver" sender:self];
        
    }
    
}

@end
