//
//  DefaultVCSeven.m
//  SGPagingViewExample
//
//  Created by kingsic on 2017/10/17.
//  Copyright © 2017年 Sorgle. All rights reserved.
//

#import "DefaultVCSeven.h"
#import "SGPagingView.h"
#import "ChildVCFull.h"

@interface DefaultVCSeven () <SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation DefaultVCSeven

- (void)dealloc {
    NSLog(@"DefaultVCSeven - - dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPageView];
}

- (void)setupPageView {
    NSArray *titleArr = @[@"精选", @"电影", @"OC", @"Swift"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleSelectedColor = [UIColor whiteColor];
    configure.indicatorStyle = SGIndicatorStyleCover;
    configure.indicatorColor = [UIColor blackColor];
    configure.indicatorAdditionalWidth = 20; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.indicatorCornerRadius = 30; // 说明：遮盖样式下，指示器的圆角大小，若设置的圆角大于指示器高度的 1/2，则指示器的圆角为指示器高度的 1/2
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.selectedIndex = 1;
    _pageTitleView.isNeedBounces = NO;
    
    ChildVCFull *oneVC = [[ChildVCFull alloc] init];
    ChildVCFull *twoVC = [[ChildVCFull alloc] init];
    ChildVCFull *threeVC = [[ChildVCFull alloc] init];
    ChildVCFull *fourVC = [[ChildVCFull alloc] init];
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC];
    /// pageContentView
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view insertSubview:_pageContentView atIndex:0];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
