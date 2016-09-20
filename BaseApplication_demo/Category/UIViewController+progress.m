//
//  UIViewController+progress.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "UIViewController+progress.h"

@implementation UIViewController (progress)

MBProgressHUD *hud;
-(void)showWaitingWithMask
{
    [SVProgressHUD showWithStatus:@"请等待"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
}
-(void)showFlagWithStatus:(ProgressTypeWithMsk) type withMessage:(NSString *)message
{
    switch (type) {
        case ProgressDefault:
        {
            [SVProgressHUD showInfoWithStatus:message];
        }
            break;
        case ProgressFailure:
        {
            [SVProgressHUD showErrorWithStatus:message];
        }
            break;
        case ProgressSuccess:
        {
            [SVProgressHUD showSuccessWithStatus:message];
        }
            break;

            
        default:
            break;
    }
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
}

-(void)showMessage:(NSString *) message isMask:(BOOL) ok
{
    [SVProgressHUD showInfoWithStatus:message];

    if (ok)
    {
        //设置默认高亮
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        //动画方式
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
        //禁止用户点击方式
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    }
    else
    {

    }
}

-(void)showAlertMessage:(NSString *)message
{
    if (!hud)
    {
        //添加到view上
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //模式
        hud.mode = MBProgressHUDModeText;
        //文字
        hud.labelText = message;
        //提示框颜色
        hud.labelColor = [UIColor blackColor];
        //文字颜色
        hud.color = [UIColor whiteColor];
        //是否程辐射显示
        hud.dimBackground = NO;
        //动画方式
        hud.animationType = MBProgressHUDAnimationZoomIn;
        //显示
        [hud show:YES];
    }
}

-(void)dismissAllHUD
{
    if ([SVProgressHUD isVisible])
    {
        [SVProgressHUD dismissWithDelay:0.2];
    }
    if (hud)
    {
        [hud hide:YES afterDelay:0.2];
        [hud removeFromSuperViewOnHide];
    }
    
}
@end
