//
//  BirthDayViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/14.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BirthDayViewController.h"

@interface BirthDayViewController ()

@end

@implementation BirthDayViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"BirthDayViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic {
    self.dataList = self.setting.birthdayList;
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
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    KinenbiData *kinenbi = [self.dataList objectAtIndex:indexPath.row];
    //タイトル
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,25,280,25)];
    titleLabel.text = kinenbi.name;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    titleLabel.alpha = 1.0f;
    titleLabel.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:titleLabel];
    
    //日にち
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(200,25,250,25)];
    dayLabel.text = kinenbi.date;
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    dayLabel.textColor = [UIColor grayColor];
    dayLabel.alpha = 1.0f;
    dayLabel.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:dayLabel];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (IBAction)addAction:(id)sender {
}
@end
