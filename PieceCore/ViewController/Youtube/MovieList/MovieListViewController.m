//
//  MovieListViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2016/01/26.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "MovieListViewController.h"
#import "PlayYoutubeViewController.h"
#import "PlayHologramYoutubeViewController.h"

@interface MovieListViewController ()
@property(nonatomic) NSMutableArray *movieList;

@end

@implementation MovieListViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"MovieListViewController" owner:self options:nil];
}
-(void)viewDidLoadLogic{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].movieListTitle;
    }
    
}
-(void)viewDidAppearLogic{
    [self loadData];
    [self.table reloadData];
}
-(void)loadData{
    NSData *moveListData = [[NSUserDefaults standardUserDefaults] objectForKey:@"MOVE_LIST"];
    NSMutableArray *movieList;
    if (moveListData) {
        movieList = [NSKeyedUnarchiver unarchiveObjectWithData:moveListData];
    }
    
    if (movieList.count == 0) {
        movieList = [NSMutableArray array];
    }
    self.movieList = movieList;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic = [self.movieList objectAtIndex:indexPath.row];
        NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        
        if ([Common isNotEmptyString:[dic valueForKey:@"DATE" ]]) {
            UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(130,30,self.viewSize.width - 110,40)];
            textLbl.text = [dic valueForKey:@"DATE" ];
            textLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
            textLbl.alpha = 1.0f;
            textLbl.backgroundColor = [UIColor clearColor];
            textLbl.numberOfLines = 2;
            [cell.contentView addSubview:textLbl];
        }
    
    UIImageView *iv;
    if ([[dic valueForKey:@"TYPE" ] isEqualToString:@"1"]) {
        iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie.png"]];
    } else if ([[dic valueForKey:@"TYPE" ] isEqualToString:@"2"]) {
        iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3dmovie.png"]];
    }

    iv.frame = CGRectMake(30, 20, 50, 50);
    [cell.contentView addSubview:iv];
        //}
        return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90.0f;
    } else {
        return 60.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic = [self.movieList objectAtIndex:indexPath.row];
    if ([[dic valueForKey:@"TYPE" ] isEqualToString:@"1"]) {
        PlayYoutubeViewController *vc = [[PlayYoutubeViewController alloc]initWithNibName:@"PlayYoutubeViewController" bundle:nil
                                         ];
        vc.youtubeId = [dic valueForKey:@"YOUTUBEID"];
        [self presentViewController:vc animated:YES completion:nil];
        
    } else if ([[dic valueForKey:@"TYPE" ] isEqualToString:@"2"]){
        PlayHologramYoutubeViewController *vc = [[PlayHologramYoutubeViewController alloc]initWithNibName:@"PlayHologramYoutubeViewController" bundle:nil
                                         ];
        vc.youtubeId = [dic valueForKey:@"YOUTUBEID"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

@end
