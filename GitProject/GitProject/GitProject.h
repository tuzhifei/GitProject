//
//  GitProject.h
//  GitProject
//
//  Created by mark on 2019/7/30.
//  Copyright © 2019 mark. All rights reserved.
//

#ifndef GitProject_h
#define GitProject_h

#define kAPPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define tabbarSize (self.hidesBottomBarWhenPushed ? CGSizeZero : self.navigationController.tabBarController.tabBar.frame.size)
#define navigationBarSize (self.navigationController.navigationBar.frame.size)
#define statusFrameSize ([UIApplication sharedApplication].statusBarFrame.size)

// use to iPad
#define isIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// use to iphone 4,4s,5s,5c,SE
#define isIphoneSmall (([UIScreen mainScreen].bounds.size.height == 568) || ([UIScreen mainScreen].bounds.size.height == 480))
// use to iphone 5,5s,6,7,8
#define isIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// use to iphone 6P,7P,8P
#define isIPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
// use to iphoneX,XR,XS,XS Max
#define isIPhoneFill (([UIScreen mainScreen].bounds.size.height == 812) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO))

#define kNavigationHeight (isIPhoneFill?88:64)
#define kTabbarHeight (isIPhoneFill?83:49)
#define kSafeAreaHeight (isIPhoneFill?34:0)
#define kStatusHeight (isIPhoneFill?44:20)

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/*颜色定义方式
 */
#define SM_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0*a]
#define SM_RGB(r, g, b) SM_COLOR(r, g, b, 1.0f)
#define SM_COLORHEX(hex, a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1.0*a]

/*具体颜色
 */
#define WHITE_COLOR             [UIColor whiteColor] // 白色
#define kTextfieldBorderColor   SM_COLORHEX(0xFFFFFF,.1)//输入框边框颜色
#define kSunmiColor_normal      SM_COLORHEX(0xF26821,1)//商米色
#define kSunmiColor_alpha       SM_COLORHEX(0xF26821,.6)//浅色商米色
#define kSunmiLabelAlpha(a)     SM_COLORHEX(0x333C4F,a) // label色
#define kSunmiOrange            SM_COLORHEX(0xFF6000,1) // 按钮橘色 光标
#define COLOR_33                SM_COLORHEX(0x333338,1)
#define COLOR_85                SM_COLORHEX(0x85858A,1)
#define COLOR_85_light          SM_COLORHEX(0x85858A,.6)
#define COLOR_BackGround        SM_COLORHEX(0xFAFAFA,1) // 背景色
#define COLOR_Line              SM_COLORHEX(0x000000,.1) // 分割线颜色
#define COLOR_Unable            SM_COLORHEX(0xBBBBC7,1) //灰色



#define COLOR_TrackTint   SM_RGB(240, 242, 245)



static NSString *Medium_Font   = @"PingFangSC-Medium";
static NSString *Regular_Font  = @"PingFangSC-Regular";
static NSString *Semibold_Font = @"PingFangSC-Semibold";
static NSString *DinM_Font     = @"DIN-MediumItalic";
static NSString *DINPro_Font     = @"DINPro-Medium";



#endif /* GitProject_h */
