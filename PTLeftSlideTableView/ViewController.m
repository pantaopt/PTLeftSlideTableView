//
//  ViewController.m
//  PTLeftSlideTableView
//
//  Created by wkr on 16/7/22.
//  Copyright © 2016年 pantao. All rights reserved.
//

#import "ViewController.h"
#import "PTLeftSlideTableView.h"

@interface ViewController ()<PTLeftSlideTableViewDelegate,PTLeftSlideTableViewDatasource>

@property (nonatomic, strong) PTLeftSlideTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView.view];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"移动" style:UIBarButtonItemStylePlain target:self action:@selector(move)];
}

- (void)move{
    [self.tableView editing:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
}

- (void)done{
    [self.tableView editing:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"移动" style:UIBarButtonItemStylePlain target:self action:@selector(move)];
}

- (void)PTTableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"被移动的 :%ld",(long)sourceIndexPath.row);
    
    NSLog(@"目标 :%ld",(long)destinationIndexPath.row);
}

- (NSInteger)PTtableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)PTtableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)PTtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"uitableviewcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}

- (BOOL)PTTableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)PTTableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)PTClickDeleteConfirmationViewBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%@ %ld",btn.currentTitle,(long)indexPath.row);
//    [self.tableView PTReload];
    [self.tableView PTReloadRowsAtIndexPathWithRowAnimation:UITableViewRowAnimationMiddle];
}

- (PTLeftSlideTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PTLeftSlideTableView alloc]init];
        [_tableView.view setFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        _tableView.PTdelegate = self;
        _tableView.PTdataSource = self;
        _tableView.btnFont = 11.0;
        _tableView.btnWidth = 74.0;
        _tableView.editingArr = @[@"置顶",@"删除"];
        _tableView.editingBgColorArr = @[[UIColor yellowColor],[UIColor redColor]];
        _tableView.editingTColorArr = @[[UIColor blueColor],[UIColor blackColor]];
    }
    return _tableView;
}

@end
