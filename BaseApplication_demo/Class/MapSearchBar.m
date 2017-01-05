//
//  MapSearchBar.m
//  BaseApplication_demo
//
//  Created by FeZo on 17/1/3.
//  Copyright © 2017年 FezoLsp. All rights reserved.
//

#import "MapSearchBar.h"

@implementation MapSearchBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {

        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.placeholder = @"小区/写字楼/学校等"; // 设置提示文字
        //输入框
        UITextField *field = [self valueForKey:@"searchField"];
        [field setTintColor:[UIColor redColor]];
        //取消btn
        UIButton *cancelButton = [self valueForKey:@"cancelButton"];
        [cancelButton setTitle:@"返回"forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    return self;
}

#pragma mark ------------delegate --------------
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    // return NO to not become first responder
    searchBar.showsCancelButton = YES;
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // called when text starts editing
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
    // return NO to not resign first responder
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // called when text ends editing
    searchBar.showsCancelButton = NO;

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // called when text changes (including clear)
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    return YES;
}// called before text changes

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED // called when bookmark button pressed
{
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED   // called when cancel button pressed
{
    
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED// called when search results button pressed
{
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0)
{
    
}
@end
