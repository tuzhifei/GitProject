//
//  PageCollectionView.m
//  ChartsDemo
//
//  Created by mark on 2019/6/5.
//  Copyright © 2019 mark. All rights reserved.
//

#import "PageCollectionView.h"
#import "MJRefresh.h"
@implementation PageCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initCollectionView];
    }
    return self;
}

- (void)initCollectionView{
    //    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)setIsHasHeaderRefresh:(BOOL)isHasHeaderRefresh {
    if (!isHasHeaderRefresh) {
        self.mj_header = nil;
    }else{
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)requestData {
    NSLog(@"请求数据");
}

@end
