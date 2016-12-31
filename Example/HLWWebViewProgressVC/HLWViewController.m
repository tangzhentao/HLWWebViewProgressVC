//
//  HLWViewController.m
//  HLWWebViewProgressVC
//
//  Created by tangzhentao on 12/31/2016.
//  Copyright (c) 2016 tangzhentao. All rights reserved.
//

#import "HLWViewController.h"
#import "HLWWebViewProgressVC.h"
#import <WebKit/WebKit.h>

@interface HLWViewController ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView * webView;
@property (strong, nonatomic) HLWWebViewProgressVC * webViewProgressVC;

@end

@implementation HLWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self addNavigationItems];

    [self addWebView];
    
    [self loadWebpage];
    
}

- (void)addNavigationItems
{
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                 target:self
                                                                                 action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = refreshItem;
}

- (void)refresh
{
    NSLog(@"%s", __func__);
    [self.webView reload];
}

- (void)addWebView
{
    CGRect frame = self.view.frame;
    NSLog(@"frame: %@", NSStringFromCGRect(frame));
    
    _webView = [[WKWebView alloc] initWithFrame:frame];
    _webView.navigationDelegate = self;
    
    [self.view addSubview:_webView];
    
    _webViewProgressVC = [HLWWebViewProgressVC webViewProgressVCWithWebView:_webView
                                                              navigationBar:self.navigationController.navigationBar];
    _webViewProgressVC.progressView.tintColor = [UIColor greenColor];
}
- (void)loadWebpage
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.sina.com.cn"]];
    
    [self.webView loadRequest:request];
}

#pragma mark - ---------- WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
{
    NSLog(@"%s", __func__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id title, NSError * _Nullable error) {
        self.title = title;
    }];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
