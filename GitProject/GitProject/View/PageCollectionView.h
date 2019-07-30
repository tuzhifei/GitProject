//
//  PageCollectionView.h
//  ChartsDemo
//
//  Created by mark on 2019/6/5.
//  Copyright © 2019 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageCollectionView : UICollectionView <UIGestureRecognizerDelegate>

//**获取UICollectionView偏移量的Block*/
@property (nonatomic , copy) void(^scrollViewDidScroll)(UIScrollView * scrollView);


/**是否同时响应多个手势 默认NO*/
@property (nonatomic , assign) BOOL  canResponseMutiGesture;

/**
 是否有头部刷新  默认YES
 */
@property (nonatomic,assign) BOOL isHasHeaderRefresh;


@end

NS_ASSUME_NONNULL_END
