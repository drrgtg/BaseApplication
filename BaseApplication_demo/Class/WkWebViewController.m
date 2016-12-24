//
//  ViewController2.m
//  WKWebView_OBJC
//
//  Created by FeZo on 16/9/2.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "WkWebViewController.h"
#import <WebKit/WebKit.h>


@interface WkWebViewController ()<
WKUIDelegate,
WKNavigationDelegate,
WKScriptMessageHandler
>

@property (strong, nonatomic) WKWebView   *webView;
@end

@implementation WkWebViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    NSURLRequest  *req=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"dirName/店长推荐.htm"]]];
    
    
    [self.webView loadRequest:req];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(clickRight)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickRight
{
    [self.webView evaluateJavaScript:@"more()" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        
    }];
}
///结束的时候移除注册的方法，不然会内存泄露
- (void)dealloc
{
    //移除注册
    [self removeScriptMessage];
    //清除cookies
    [self clearCookies];
}

- (void)clearCookies
{
    //如果iOS8
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
    NSError *errors;
    [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    //如果iOS9到之后
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         for (WKWebsiteDataRecord *record  in records)
                         {
                             if ( [record.displayName containsString:@"facebook"])
                             {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                             }
                         }
                     }];
}

- (void)removeScriptMessage
{
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"NativeMethod"];
    
}
- (WKWebView *)webView
{
    if (!_webView)
    {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKUserContentController* userContent = [[WKUserContentController alloc] init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [userContent addScriptMessageHandler:self name:@"NativeMethod"];
        // 将UserConttentController设置到配置文件
        config.userContentController = userContent;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:config];
        
        
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
    }
    return _webView;
}

- (void)NativeMethod:(id)obj
{
    NSDictionary *dic = obj;
    
    NSLog(@"%@",dic[@"gid"]);
    [self showAlertMessage:[NSString stringWithFormat:@"点击调用原生方法并传值:%@",dic[@"gid"]]];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissAllHUD];
    });
}


#pragma mark ------------wkScriptMessagehandler --------------
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //js传递过来的参数
    NSLog(@"%@",message.body);
    //js调用的方法和本地的方法
    NSLog(@"%@",message.name);
    //参数class
    NSLog(@"%@",[message.body class]);
    
    NSString *sel = [message.name stringByAppendingString:@":"];
    
    SEL ch = sel_registerName([sel UTF8String]);
    
    [self performSelector:(ch) withObject:message.body afterDelay:0];
    
    //    [self.webView evaluateJavaScript:@"more()" completionHandler:nil];
}
#pragma mark ------------wkNavigationDelegate --------------

/*! @abstract Decides whether to allow or cancel a navigation.
 @param webView The web view invoking the delegate method.
 @param navigationAction Descriptive information about the action
 triggering the navigation request.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
 @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%s",__FUNCTION__);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%s",__FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}

/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"%s",__FUNCTION__);
    
}

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"%s",__FUNCTION__);
    
}

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
    
}

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"%s",__FUNCTION__);
    
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"%s",__FUNCTION__);
    
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
}

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
//{
//    NSLog(@"%s",__FUNCTION__);
//
//}

/*! @abstract Invoked when the web view's web content process is terminated.
 @param webView The web view whose underlying web content process was terminated.
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s",__FUNCTION__);
    
}
#pragma mark ------------wkUiDelegate --------------


/*! @abstract Creates a new web view.
 @param webView The web view invoking the delegate method.
 @param configuration The configuration to use when creating the new web
 view.
 @param navigationAction The navigation action causing the new web view to
 be created.
 @param windowFeatures Window features requested by the webpage.
 @result A new web view or nil.
 @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.
 
 If you do not implement this method, the web view will cancel the navigation.
 */
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//
//}

/*! @abstract Notifies your app that the DOM window object's close() method completed successfully.
 @param webView The web view invoking the delegate method.
 @discussion Your app should remove the web view from the view hierarchy and update
 the UI as needed, such as by closing the containing browser tab or window.
 */
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    
}

/*! @abstract Displays a JavaScript alert panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param frame Information about the frame whose JavaScript initiated this
 call.
 @param completionHandler The completion handler to call after the alert
 panel has been dismissed.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have a single OK button.
 
 If you do not implement this method, the web view will behave as if the user selected the OK button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    NSLog(@"%s",__FUNCTION__);
    [self showFlagWithStatus:ProgressSuccess withMessage:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissAllHUD];
    });
    completionHandler();
    
}

/*! @abstract Displays a JavaScript confirm panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the confirm
 panel has been dismissed. Pass YES if the user chose OK, NO if the user
 chose Cancel.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    NSLog(@"%s",__FUNCTION__);
    completionHandler(YES);
    
}

/*! @abstract Displays a JavaScript text input panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param defaultText The initial text to display in the text entry field.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the text
 input panel has been dismissed. Pass the entered text if the user chose
 OK, otherwise nil.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel, and a field in
 which to enter text.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    NSLog(@"%s",__FUNCTION__);
    completionHandler(@"nihao");
    
}


-(void)printerNow
{
    NSLog(@"%s",__FUNCTION__);
}
@end
