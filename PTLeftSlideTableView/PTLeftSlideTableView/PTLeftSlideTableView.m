//
//  PTLeftSlideTableView.m
//  PTLeftSlideTableView
//
//  Created by wkr on 16/7/22.
//  Copyright © 2016年 pantao. All rights reserved.
//

#import "PTLeftSlideTableView.h"
#import "objc/runtime.h"

@interface PTLeftSlideTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PTLeftSlideTableView

- (void)dealloc{
    for (UIView *v in self.cell.subviews) {
        if ([v isKindOfClass:[NSClassFromString(@"UITableViewCellContentView") class]]) {
            [v addObserver:self forKeyPath:@"frame" options: NSKeyValueObservingOptionNew |
             NSKeyValueObservingOptionOld context:nil];
            [v removeObserver:self forKeyPath:@"frame"context:nil];
        }
    }
}

//- (id<PTLeftSlideTableViewDelegate>)PTdelegate{
//    return (id<PTLeftSlideTableViewDelegate>)self.tableView.delegate;
//}
//
//- (id<PTLeftSlideTableViewDatasource>)PTdatasource{
//    return (id<PTLeftSlideTableViewDatasource>)self.tableView.dataSource;
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.btnWidth = 74.0;
        self.btnFont = 15.0;
        NSMutableArray *colorArr = [NSMutableArray array];
        for (int i = 0; i < self.editingArr.count; i++) {
            [colorArr addObject:[UIColor redColor]];
        }
        self.editingBgColorArr = [NSArray arrayWithArray:colorArr];
        colorArr = [NSMutableArray array];
        for (int i = 0; i < self.editingArr.count; i++) {
            [colorArr addObject:[UIColor whiteColor]];
        }
        self.editingTColorArr = [NSArray arrayWithArray:colorArr];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.btnWidth = 74.0;
        self.btnFont = 15.0;
        NSMutableArray *colorArr = [NSMutableArray array];
        for (int i = 0; i < self.editingArr.count; i++) {
            [colorArr addObject:[UIColor redColor]];
        }
        self.editingBgColorArr = [NSArray arrayWithArray:colorArr];
        colorArr = [NSMutableArray array];
        for (int i = 0; i < self.editingArr.count; i++) {
            [colorArr addObject:[UIColor whiteColor]];
        }
        self.editingTColorArr = [NSArray arrayWithArray:colorArr];
    }
    return self;
}

#pragma mark -是否编辑
- (void)editing:(BOOL)isEditing{
    self.editing = isEditing;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.PTdataSource PTtableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.PTdataSource PTtableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.PTdataSource PTtableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.PTdelegate PTTableView:tableView canEditRowAtIndexPath:indexPath];
}

#pragma mark 左划多个按钮
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (UIView *v in self.cell.subviews) {
        if ([v isKindOfClass:[NSClassFromString(@"UITableViewCellContentView") class]]) {
            [v addObserver:self forKeyPath:@"frame" options: NSKeyValueObservingOptionNew |
             NSKeyValueObservingOptionOld context:nil];
        }
    }
    return [self configConfirmDeleteCustomViewSpaceString];
}

- (NSString *)configConfirmDeleteCustomViewSpaceString{
    NSMutableString *string = @" ".mutableCopy;
    CGSize retSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.btnHeight)
                                          options: NSStringDrawingUsesLineFragmentOrigin
                                       attributes: @{NSFontAttributeName: [UIFont systemFontOfSize:self.btnFont]}
                                          context:nil].size;
    CGFloat l = (self.btnWidth+1.0)*self.editingArr.count;
    CGFloat c = l / retSize.width;
    int count = [[NSString stringWithFormat:@"%.f",c] intValue];
    for (int i=0; i<count; i++) {
        [string appendString:@" "];
    }
    return string;
}

#pragma mark -开始编辑
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{
    self.indexPath = indexPath;
    self.cell = [tableView cellForRowAtIndexPath:indexPath];
    self.btnHeight = self.cell.frame.size.height;
    for (UIView *v in self.cell.subviews) {
        if ([v isKindOfClass:[NSClassFromString(@"UITableViewCellContentView") class]]) {
            [v addObserver:self forKeyPath:@"frame" options: NSKeyValueObservingOptionNew |
             NSKeyValueObservingOptionOld context:nil];
        }
    }
}

#pragma mark -结束编辑
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{
    
}

#pragma mark -KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    for (UIView *v in self.cell.subviews) {
        if ([v isKindOfClass:[NSClassFromString(@"UITableViewCellDeleteConfirmationView") class]]) {
            [self addSubView:[self configConfirmDeleteCustomView] toTableViewCellDeleteConfirmationView:v];
        }
    }
}

- (void)addSubView:(UIView *)view toTableViewCellDeleteConfirmationView:(UIView *)confirmationView{
    if (confirmationView.frame.size.width >= (self.btnWidth+1.0)*self.editingArr.count) {
        [confirmationView setFrame:CGRectMake(confirmationView.frame.origin.x + (confirmationView.frame.size.width-(self.btnWidth+1.0)*self.editingArr.count),
                                             confirmationView.frame.origin.y,
                                             (self.btnWidth+1.0)*self.editingArr.count,
                                              confirmationView.frame.size.height)];
    }
    if (objc_getAssociatedObject(confirmationView, (__bridge const void *)(self.cell))) {
        return;
    }
    [confirmationView addSubview:view];
    objc_setAssociatedObject(confirmationView, (__bridge const void *)(self.cell), view, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark -创建左划出来的视图
- (UIView *)configConfirmDeleteCustomView{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.btnWidth+1)*self.editingArr.count, self.btnHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<self.editingArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(self.btnWidth+1), 0, self.btnWidth, self.btnHeight)];
        btn.backgroundColor = self.editingBgColorArr[i];
        [btn setTitle:self.editingArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.editingTColorArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.btnFont];
        [contentView addSubview:btn];
    }
    return contentView;
}

#pragma 左划出的按钮点击事件
- (void)confirm:(UIButton *)btn{
    [self.PTdelegate PTClickDeleteConfirmationViewBtn:btn indexPath:self.indexPath];
}

#pragma mark -移动cell
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.PTdataSource PTTableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

#pragma mark -然后cell的编辑模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return UITableViewCellEditingStyleNone;
    return [self.PTdelegate PTTableView:tableView editingStyleForRowAtIndexPath:indexPath];
}

#pragma mark -全局刷新
- (void)PTReload{
    [self reloadData];
}

#pragma mark -单行更新
- (void)PTReloadRowsAtIndexPathWithRowAnimation:(UITableViewRowAnimation)animation{
    [self reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}



@end
