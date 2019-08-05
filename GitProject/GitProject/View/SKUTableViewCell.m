//
//  SKUTableViewCell.m
//  ChartsDemo
//
//  Created by mark on 2019/6/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import "SKUTableViewCell.h"
//#import "ChartDemo.h"
#import "SaleRankModel.h"
@interface SKUTableViewCell ()

@property(nonatomic, strong)UILabel *rankLab;
@property(nonatomic, strong)UILabel *describeLab;
@property(nonatomic, strong)UILabel *detailLab;
@property(nonatomic, strong)UIView *lineView;

@end

@implementation SKUTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.rankLab];
        [self.contentView addSubview:self.describeLab];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (UILabel *)rankLab {
    if (_rankLab == nil) {
        _rankLab = [[UILabel alloc]init];
        _rankLab.textAlignment = NSTextAlignmentCenter;
        _rankLab.font = [UIFont fontWithName:Regular_Font size:12];
    }
    return _rankLab;
}

- (UILabel *)describeLab {
    if (_describeLab == nil) {
        _describeLab = [[UILabel alloc]init];
        _describeLab.textAlignment = NSTextAlignmentLeft;
        _describeLab.text = @"--";
        _describeLab.font = [UIFont fontWithName:Regular_Font size:12];
        _describeLab.textColor = COLOR_33;

    }
    return _describeLab;
}

- (UILabel *)detailLab {
    if (_detailLab == nil) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.text = @"--";
        _detailLab.font = [UIFont fontWithName:Regular_Font size:12];
        _detailLab.textColor = COLOR_33;
        
    }
    return _detailLab;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = COLOR_Line;
    }
    return _lineView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    CGFloat lineHeight = 0.3f;
    self.rankLab.frame = CGRectMake(5, height *.5f - 10, 20, 20);
    ViewBorderRadius(self.rankLab, 10.0f, 1, [UIColor clearColor]);
    
    self.describeLab.frame = CGRectMake(CGRectGetMaxX(self.rankLab.frame) + 15, 0, width *.3f, height - lineHeight);
    self.detailLab.frame = CGRectMake(width *.6f , 0, width *.4f - 20, height - lineHeight);
    self.lineView.frame = CGRectMake(CGRectGetMinX(self.describeLab.frame), height - lineHeight, width - CGRectGetMinX(self.describeLab.frame) , lineHeight);
}

- (void)configWithModel:(SaleRankModel *)model {
    int rank = model.rank;
    if (rank > 3) {
        self.rankLab.backgroundColor = [UIColor whiteColor];
        self.rankLab.textColor = COLOR_85;
    } else {
        UIColor *color = nil;
        if (rank == 1)  color = SM_RGB(255, 0, 4);
        else if (rank == 2) color = SM_RGB(255, 91, 4);
        else color = SM_RGB(255, 197, 6);
        self.rankLab.backgroundColor = color;
        self.rankLab.textColor = [UIColor whiteColor];
    }
    self.rankLab.text = [NSString stringWithFormat:@"%d", rank];
    self.describeLab.text = model.name;
    if (model.quantity != 0) {
        self.detailLab.text = [NSString stringWithFormat:@"%ld", model.quantity];
    } else {
        self.detailLab.text = @"--";
    }
}

- (void)setHidden:(BOOL)hidden {
    if (hidden) {
        [self.lineView setHidden:YES];
    } else {
        [self.lineView setHidden:NO];
    }
}

@end
