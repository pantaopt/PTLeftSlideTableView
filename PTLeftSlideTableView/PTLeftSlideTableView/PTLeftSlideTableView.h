//
//  PTLeftSlideTableView.h
//  PTLeftSlideTableView
//
//  Created by wkr on 16/7/22.
//  Copyright © 2016年 pantao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTLeftSlideTableViewDelegate
@optional

- (void)PTClickDeleteConfirmationViewBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;

- (BOOL)PTTableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCellEditingStyle)PTTableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol PTLeftSlideTableViewDatasource

@optional
- (NSInteger)PTtableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CGFloat)PTtableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)PTtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)PTTableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end

@interface PTLeftSlideTableView : UITableView

@property (weak, nonatomic) id<PTLeftSlideTableViewDatasource> PTdataSource;
@property (weak, nonatomic) id<PTLeftSlideTableViewDelegate> PTdelegate;

@property (strong, nonatomic) NSArray *editingArr;
@property (strong, nonatomic) NSArray *editingBgColorArr;
@property (strong, nonatomic) NSArray *editingTColorArr;
@property (strong, nonatomic) UITableViewCell *cell;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (assign, nonatomic) float btnHeight;
@property (assign, nonatomic) float btnWidth;
@property (assign, nonatomic) float btnFont;

- (void)editing:(BOOL)isEditing;

- (void)PTReload;

- (void)PTReloadRowsAtIndexPathWithRowAnimation:(UITableViewRowAnimation)animation;

@end
