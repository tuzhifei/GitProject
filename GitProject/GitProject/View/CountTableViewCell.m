//
//  CountTableViewCell.m
//  ChartsDemo
//
//  Created by mark on 2019/5/30.
//  Copyright © 2019 mark. All rights reserved.
//

#import "CountTableViewCell.h"
#import "PurchaseModel.h"
@interface CountTableViewCell ()

@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UIImageView *tagImg;
@property(nonatomic, strong)UILabel *percentLab;


@end

@implementation CountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.percentLab];
        [self.contentView addSubview:self.tagImg];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

- (UILabel *)percentLab {
    if (_percentLab == nil) {
        _percentLab = [[UILabel alloc]init];
        _percentLab.font = [UIFont fontWithName:Medium_Font size:12];
        _percentLab.textColor = COLOR_33;
        _percentLab.text = @"  --%";
        _percentLab.textAlignment = NSTextAlignmentLeft;

    }
    return _percentLab;
}

- (UIImageView *)tagImg {
    if (_tagImg == nil) {
        _tagImg = [[UIImageView alloc]init];
        _tagImg.backgroundColor = [UIColor redColor];
    }
    return _tagImg;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont fontWithName:Regular_Font size:12];
        _titleLab.textColor = COLOR_85;
        _titleLab.text = @"支付宝";
    }
    return _titleLab;
}

- (void)setIsRight:(BOOL)isRight {
    _isRight = isRight;
    if (isRight) {
        self.titleLab.textAlignment = NSTextAlignmentRight;
        self.percentLab.textAlignment = NSTextAlignmentRight;
    } else {
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        self.percentLab.textAlignment = NSTextAlignmentLeft;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.isRight) {
        self.percentLab.frame = CGRectMake(8, self.contentView.centerY - 12, self.contentView.width - 16, 18);
        self.titleLab.frame = CGRectMake(8, self.percentLab.bottom, self.contentView.width - 16, 18);
        self.tagImg.frame = CGRectMake(0, self.titleLab.centerY - 2 , 4, 4);

    } else {
        self.percentLab.frame = CGRectMake(0, self.contentView.centerY - 12, self.contentView.width - 16, 18);
        self.titleLab.frame = CGRectMake(0, self.percentLab.bottom, self.contentView.width - 16, 18);
        self.tagImg.frame = CGRectMake(self.titleLab.right + 4, self.titleLab.centerY - 2, 4, 4);
    }
   
    self.tagImg.layer.cornerRadius = 2.0f;
    self.tagImg.layer.masksToBounds = YES;


}

- (void)configWithModel:(PurchaseModel *)model {
//    self.titleLab.attributedText = [self designWithName:model.name percent:model.percent * 100];
//    self.tagImg.backgroundColor =  model.color;
    if (isnan(model.percent)) model.percent = 0;
    if (model.percent <= 0) {
        self.percentLab.text = @"0%";
    } else {
        self.percentLab.text = [NSString stringWithFormat:@"%.1f%%", model.percent * 100];
    }
    self.tagImg.backgroundColor = model.color;
    self.titleLab.text = model.purchase_type_name;
}

- (NSAttributedString *)designWithName:(NSString *)name percent:(CGFloat)percent {
    NSString *percentStr = [NSString stringWithFormat:@"|   %.f%%", percent];
    NSString *allStr = [NSString stringWithFormat:@"%@   %@", name, percentStr];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    [attStr setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                            NSForegroundColorAttributeName:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1]
                            } range:NSMakeRange(0, name.length)];
    [attStr setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                            NSForegroundColorAttributeName:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]
                            }  range:NSMakeRange(allStr.length - percentStr.length , percentStr.length)];
    return attStr;
}

@end
