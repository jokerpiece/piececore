//
//  SettingViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/09.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SettingViewController.h"
#import "SexViewController.h"
#import "BirthdayDetailViewController.h"
#import "JobViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"SettingViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic {
    self.menuList = [[NSArray alloc] initWithObjects:@"性別", @"誕生日", @"記念日", @"職業", nil];
    self.pointLbl.text = @"3125 P";
    self.pointLbl.font = [UIFont fontWithName:@"CabinSketch-Bold" size:28.0f];
    self.pointLbl.textColor = [UIColor redColor];
    
    self.setting = [Common getSettingModel];
    if (self.setting == nil) {
        self.setting = [[SettingData alloc]init];
        self.setting.birthdayList = [NSMutableArray array];
        self.setting.kinenbiList = [NSMutableArray array];
    }
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppearLogic{
    [self.table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return self.menuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    //タイトル
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70,25,280,25)];
    label.text = [self.menuList objectAtIndex:indexPath.row];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    label.alpha = 1.0f;
    label.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    
    NSString *selectName;
    switch (indexPath.row) {
        case 0:
        {
            if (self.setting.sex.length == 0) {
                selectName = @"未設定";
            } else {
                selectName = self.setting.sex;
            }
            break;
        }
        case 1:
        {
            
            if (self.setting.birthdayList.count == 0) {
                selectName = @"未設定";
            } else {
                selectName = [NSString stringWithFormat:@"%d件設定",(int)self.setting.birthdayList.count ];
            }
            
            break;
        }
        case 2:
        {
            
            if (self.setting.kinenbiList.count == 0) {
                selectName = @"未設定";
            } else {
                selectName = [NSString stringWithFormat:@"%d件設定",(int)self.setting.kinenbiList.count ];
            }
            
            break;
        }
        case 3:
            if (self.setting.job.length == 0) {
                selectName = @"未設定";
            } else {
                selectName = self.setting.job;
            }
            
            break;
        default:
            break;
    }
    
    UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(170,25,130,25)];
    selectLabel.text = selectName;
    selectLabel.font = [UIFont fontWithName:@"AppleGothic" size:16];
    selectLabel.alpha = 1.0f;
    selectLabel.textColor = [UIColor grayColor];
    selectLabel.backgroundColor = [UIColor clearColor];
    selectLabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:selectLabel];
    

    NSString *imgName;
    switch (indexPath.row) {
        case 0:
            imgName = @"sex.png";
            break;
        case 1:
            imgName = @"barthday.png";
            break;
        case 2:
            imgName = @"kinenbi.png";
            break;
        case 3:
            imgName = @"work.png";
            break;
        default:
            break;
    }
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(10, 20, 32, 32);
    imgView.image = [UIImage imageNamed:imgName];
    [cell.contentView addSubview:imgView];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SexViewController *vc =[[SexViewController alloc] initWithNibName:@"SexViewController" bundle:nil];
        vc.setting = self.setting;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        BirthdayDetailViewController *vc =[[BirthdayDetailViewController alloc] initWithNibName:@"BirthdayDetailViewController" bundle:nil];
        vc.setting = self.setting;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        KinenbiViewController *vc = [[KinenbiViewController alloc] initWithNibName:@"KinenbiViewController" bundle:nil];
        vc.setting = self.setting;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        JobViewController *vc =[[JobViewController alloc] initWithNibName:@"JobViewController" bundle:nil];
        vc.setting = self.setting;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


@end
