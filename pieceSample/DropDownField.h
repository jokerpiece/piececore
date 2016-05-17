//
//  DropDownField.h
//  pieceSample
//
//  Created by OhnumaRina on 2016/05/17.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectKikakuNameDelegate <NSObject>

@optional
- (void)selectKikakuName:(NSString *)kikakuName;

@end

@interface DropDownField : UITextField <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<SelectKikakuNameDelegate> delegate;

@property (nonatomic) NSArray* dropList;            // 表示するドロップリスト
@property (nonatomic) CGFloat displayNumOfRows;     // 表示件数
@property (nonatomic) CGFloat heightOfListItem;     // リストアイテムの高さ
@property (nonatomic) UIColor* borderColorForList;  // リストの枠線
@property (nonatomic) UIFont* fontOfListItem;       // リストアイテムのフォント


@end
