//
//  ViewController.m
//  GitProject
//
//  Created by mark on 2019/7/26.
//  Copyright © 2019 mark. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UIView *view = [[UIView alloc]init];
    view.frame = self.view.bounds;
    [self.view addSubview:view];
}
@end
