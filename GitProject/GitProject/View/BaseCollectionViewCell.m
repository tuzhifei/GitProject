//
//  BaseCollectionViewCell.m
//  GitProject
//
//  Created by mark on 2019/7/30.
//  Copyright © 2019 mark. All rights reserved.
//

#import "BaseCollectionViewCell.h"

typedef void(^SelectBlock)(NSInteger index);
@interface BaseCollectionViewCell (){
    NSInteger type;
}

@property(nonatomic, copy)SelectBlock selectBlock;
@property(nonatomic, strong)UIView *buttonView;
@property(nonatomic, strong)UIButton *moneyBTN;
@property(nonatomic, strong)UIButton *timeBTN;



@end

@implementation BaseCollectionViewCell

+ (NSString *)cellIdentifier {
    return [NSString stringWithFormat:@"%@", [self class]];
}

+ (void)registerCellInCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self cellIdentifier]];
}

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath atCollectionView:(UICollectionView *)collectionView {
    NSLog(@"identify: %@", [self cellIdentifier]);
    return [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ViewBorderRadius(self, 6, 1, [UIColor lightGrayColor]);
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.buttonView];
        [self loadBtnView];
    }
    return self;
}

// 抽象方法
- (void)updateWithModel:(id)model {
    self.model = model;
}

+ (CGSize)cellSize {
    return CGSizeMake(1, 1);
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"支付方式";
        _titleLab.textColor = RGB(51, 51, 56);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont fontWithName:Medium_Font size:16];
//        ViewBorderRadius(_titleLab, 1, 4, [UIColor RandomColor]);
    }
    return _titleLab;
}

- (UIView *)buttonView {
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc]init];
        _buttonView.backgroundColor = [UIColor whiteColor];
//        ViewBorderRadius(_buttonView, 12, .05f, RGB(133, 133, 133));
    }
    return _buttonView;
}

- (void)loadBtnView {
    NSArray *titleArray = @[@"按销售额", @"按订单数"];
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * 62, 0, 62, 24);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:Regular_Font size:10];
        [btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:COLOR_85 forState:UIControlStateNormal];
        [btn setTitleColor:SM_RGB(240, 80, 0) forState:UIControlStateSelected];
        [self.buttonView addSubview:btn];
        if (i == 0) {
            self.moneyBTN = btn;
            [btn setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"left_active"] forState:UIControlStateSelected];
            [self selectClick:btn];
        } else {
            self.timeBTN = btn;
            [btn setSelected:NO];
            [btn setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"right_active"] forState:UIControlStateSelected];
        }
    }
}

- (void)selectClick:(UIButton *)sender {
    if(sender == self.moneyBTN) {
        type = 0;
        [self.moneyBTN setSelected:YES];
        [self.timeBTN setSelected:NO];
    }
    if (sender == self.timeBTN) {
        type = 1;
        [self.moneyBTN setSelected:NO];
        [self.timeBTN setSelected:YES];
    }
    if (self.selectBlock) {
        self.selectBlock(type);
    }
}


- (void)segementSelectBlock:(void (^)(NSInteger index))selectBlock {
    self.selectBlock = selectBlock;
}

- (void)setIsHidden:(BOOL)isHidden {
    if (isHidden) {
        [self.buttonView setHidden:YES];
    }
    else {
        [self.buttonView setHidden:NO];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
    self.titleLab.frame = CGRectMake(20, 10, 100, 24);
    self.buttonView.frame = CGRectMake(width - 128 - 20, CGRectGetMidY(self.titleLab.frame) - 12.0f, 128, 24);
   
}




@end
