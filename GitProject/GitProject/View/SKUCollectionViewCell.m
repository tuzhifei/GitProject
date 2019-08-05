//
//  SKUCollectionViewCell.m
//  ChartsDemo
//
//  Created by mark on 2019/6/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import "SKUCollectionViewCell.h"
#import "SKUTableViewCell.h"
#import "SaleRankModel.h"
@interface SKUCollectionViewCell()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation SKUCollectionViewCell

+ (CGSize)cellSize {
    CGFloat width = kScreenWidth - 20;
    return CGSizeMake(width, 405);
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setIsHidden:YES];
        [self.titleLab setText:@"商品销量排行"];
        [self.contentView addSubview:self.tableView];
    }
    return self;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 36;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
//        ViewBorderRadius(_tableView, 1, 1, [UIColor RandomColor]);
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"SKUCollectionViewCell";
    SKUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[SKUTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SaleRankModel *model = self.dataSource[indexPath.row];
    [cell configWithModel:model];
    //隐藏最后分割线
    if (indexPath.row == 9) {
        [cell setHidden:YES];
    } else {
        [cell setHidden:NO];
    }
    return cell;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
//    CGFloat height = self.contentView.bounds.size.height;
    self.tableView.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame) + 5, width - 30, 36 * 10);
}

- (void)reloadWithDataSource:(NSArray <SaleRankModel *> *)dataSource {
    [self.dataSource removeAllObjects];
    NSMutableArray <SaleRankModel *> *handelArr = [[NSMutableArray alloc]initWithArray:dataSource];
    if (dataSource.count < 10) {
        NSInteger calculate = 10 - dataSource.count;
        for (NSInteger i = 1; i <= calculate; i++) {
            SaleRankModel *model = [[SaleRankModel alloc]init];
            model.rank = (int)(dataSource.count + i);
            model.name = @"--";
            model.quantity = 0;
            [handelArr addObject:model];
        }
    } else {
        for (int i = 0; i < 10; i++) {
            SaleRankModel *model = dataSource[i];
            [handelArr addObject:model];
        }
    }
    [self.dataSource addObjectsFromArray:handelArr];
    [self.tableView reloadData];
}

@end
