//
//  HistoryViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/20.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"HistoryViewController" owner:self options:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0] ;
        HistoryItemData *model = [self.data.historyItemList objectAtIndex:indexPath.row];
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake(10, 10, 80, 80);
        NSURL *imageURL = [NSURL URLWithString:model.img_url];
        
        [iv sd_setImageWithURL:imageURL
              placeholderImage:[UIImage imageNamed:@"wait.jpg"]
                       options:SDWebImageCacheMemoryOnly
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     }];
        [cell.contentView addSubview:iv];
        
        UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(100,30,200,40)];
        textLbl.text = model.item_text;
        textLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
        textLbl.alpha = 1.0f;
        textLbl.backgroundColor = [UIColor clearColor];
        textLbl.numberOfLines = 2;
        [cell.contentView addSubview:textLbl];
        
        
        UILabel *statesLbl = [[UILabel alloc] initWithFrame:CGRectMake(10,90,180,40)];
        statesLbl.text = [NSString stringWithFormat:@"%@",[model getDeliverName]];
        statesLbl.font = [UIFont fontWithName:@"AppleGothic" size:20];
        switch (model.deliverStatus) {
            case delivered:
                statesLbl.textColor = [UIColor flatDarkBlueColor];
                break;
            case deliver:
                statesLbl.textColor = [UIColor flatGreenColor];
                break;
            case sipment:
                statesLbl.textColor = [UIColor blackColor];
                break;
            case preparation:
                statesLbl.textColor = [UIColor grayColor];
                break;
                
            default:
                break;
        }
        statesLbl.alpha = 1.0f;
        statesLbl.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:statesLbl];
        
        UILabel *deliverDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10,120,180,40)];
        deliverDateLbl.text = [NSString stringWithFormat:@"お届け予定日：%@",self.data.strDeliverDate];
        deliverDateLbl.font = [UIFont fontWithName:@"AppleGothic" size:13];
        deliverDateLbl.alpha = 1.0f;
        deliverDateLbl.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:deliverDateLbl];
        
        
        //}
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
        return 160.0f;
    } else {
        return 60.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.data.historyItemList.count;
    }
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.selectRow = (int)indexPath.row;
        HistoryItemData *model = [self.data.historyItemList objectAtIndex:self.selectRow];
        
        DeliberyStatusViewController *vc = [[DeliberyStatusViewController alloc] initWithNibName:@"DeliberyStatusViewController" bundle:nil];
        vc.delicerStatus = model.deliverStatus;
        // 画面をPUSHで遷移させる
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (IBAction)toDeliveryAction:(id)sender {
}
@end
