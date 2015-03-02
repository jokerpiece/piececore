//
//  CategoryViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"CategoryViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic
{
    self.data.list = [NSMutableArray array];
    self.table.delegate = self;
    self.cellHeight = self.viewSize.width * 0.28;
}

- (void)viewWillAppearLogic
{
    self.isResponse = NO;
    [self syncAction];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        CategoryData *model = [self.data.list objectAtIndex:indexPath.row];
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake(0, 0, self.viewSize.width, self.cellHeight);
        NSURL *imageURL = [NSURL URLWithString:model.img_url];

        [iv sd_setImageWithURL:imageURL
              placeholderImage:[UIImage imageNamed:@"wait.jpg"]
                       options:SDWebImageCacheMemoryOnly
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                         
                     }];
        [cell.contentView addSubview:iv];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.cellHeight;
    } else {
        return 60.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.data.list.count;
    } else {
        if (self.isMore) {
            return 1;
        } else {
            return 0;
        }
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectCategory = [self.data.list objectAtIndex:indexPath.row];
    ItemListViewController *itemListVc = [[ItemListViewController alloc] initWithNibName:@"ItemListViewController" bundle:nil];
    itemListVc.isNext = YES;
    itemListVc.searchType = category;
    itemListVc.code = self.selectCategory.category_id;
    itemListVc.headerImgUrl = self.selectCategory.img_url;
    
    [self.navigationController pushViewController:itemListVc animated:YES];
    return;
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [conecter sendActionSendId:SendIdCategory param:param];
    
}

-(void)setData:(CategoryConnector *)data sendId:(NSString *)sendId{
    self.data = data;
    [self.table reloadData];
}

-(BaseConnector *)getDataWithSendId:(NSString *)sendId{
    return [CategoryConnector alloc];
}


@end
