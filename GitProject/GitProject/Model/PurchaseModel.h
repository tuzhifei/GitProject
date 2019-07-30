//
//  PurchaseModel.h
//  router
//
//  Created by mark on 2019/6/13.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseModel : NSObject


@property(nonatomic, strong)NSString *purchase_type_name;
@property(nonatomic, assign)CGFloat amount;           //销售额
@property(nonatomic, assign)NSInteger count;         //订单数
@property(nonatomic, assign)NSInteger time;
@property (nonatomic,assign)CGFloat percent;        //百分比
@property (nonatomic,strong)UIColor *color;
@property(nonatomic, assign)CGFloat total_amount; //销售额总和
@property(nonatomic, assign)NSInteger total_count;  //订单总和



+ (instancetype)createModelWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
