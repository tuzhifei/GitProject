//
//  CardCollectionViewCell.m
//  GitProject
//
//  Created by mark on 2019/7/30.
//  Copyright © 2019 mark. All rights reserved.
//

#import "CardCollectionViewCell.h"
@interface CardCollectionViewCell ()

@property(nonatomic, strong)UILabel *countLab;
@property(nonatomic, strong)UILabel *explainLab;
@property(nonatomic, strong)UILabel *dataLab;

@end


@implementation CardCollectionViewCell
+ (CGSize)cellSize {
    CGFloat width = (kScreenWidth - 30)/2;
    return  CGSizeMake(width, width * 0.6f);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setIsHidden:YES];
        [self.titleLab setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:self.countLab];
        [self.contentView addSubview:self.explainLab];
        [self.contentView addSubview:self.dataLab];
    }
    return self;
}

- (UILabel *)countLab {
    if (_countLab == nil) {
        _countLab = [[UILabel alloc]init];
        _countLab.text = @"6560";
        _countLab.textColor = [UIColor blackColor];
        _countLab.textAlignment = NSTextAlignmentLeft;
        _countLab.font = [UIFont fontWithName:Semibold_Font size:28];
        _countLab.textColor = RGB(243, 80, 0);
    }
    return _countLab;
}

- (UILabel *)explainLab {
    if (_explainLab == nil) {
        _explainLab = [[UILabel alloc]init];
        _explainLab.text = @"日环比";
        _explainLab.font = [UIFont systemFontOfSize:14];
        _explainLab.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
        _explainLab.textAlignment = NSTextAlignmentLeft;
        _explainLab.font = [UIFont fontWithName:Regular_Font size:12];
        _explainLab.textColor = RGB(133, 133, 133);
//        ViewBorderRadius(_explainLab, 1, 1, [UIColor greenColor]);
    }
    return _explainLab;
}

- (UILabel *)dataLab {
    if (_dataLab == nil) {
        _dataLab = [[UILabel alloc]init];
        _dataLab.text = @"+9%";
        _dataLab.textColor = [UIColor redColor];
        _dataLab.textAlignment = NSTextAlignmentLeft;
        _dataLab.font = [UIFont fontWithName:Medium_Font size:12];
//         ViewBorderRadius(_dataLab, 10, 0.25f, [UIColor lightGrayColor]);
    }
    return _dataLab;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    CGFloat spacing = 20.0f;
    self.titleLab.frame = CGRectMake(20, 10, width - 40, 24);
    self.countLab.frame = CGRectMake(spacing, CGRectGetMaxY(self.titleLab.frame), width - 2 * spacing, height - 42 - 22);
    self.explainLab.frame = CGRectMake(spacing, CGRectGetMaxY(self.countLab.frame), 36, 20);
    self.dataLab.frame = CGRectMake(self.explainLab.right + 5, CGRectGetMidY(self.explainLab.frame) - 10, self.countLab.width - self.explainLab.right, 20);
    
}

- (NSMutableAttributedString  *)designWithText:(NSString *)text imgStr:(NSString *)imgStr {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attStr setAttributes:@{NSFontAttributeName:[UIFont fontWithName:Medium_Font size:14],
                            } range:NSMakeRange(0, text.length)];
    NSTextAttachment *attch = [[NSTextAttachment alloc]init];
    attch.image = [UIImage imageNamed:imgStr];
    attch.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attStr insertAttributedString:string atIndex:0];
    return attStr;
}






@end
