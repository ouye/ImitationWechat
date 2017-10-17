//
//  HNSearchViewController.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 搜索 控制器 **************/

#import "HNSearchViewController.h"



@interface HNSearchViewController ()

@end

@implementation HNSearchViewController{
    UIStatusBarStyle originStatusBarStyle;
    UISearchBar *fromSearchBar;
    CGRect fromSearchBarFrame;
    UIStatusBarStyle targetStatusBarStyle;
    
    UIView *searchResultView;
    BOOL willShowSearchResultController;
    BOOL shouldHideSearchResultWhenNoSearch;
    BOOL navigationBarHidden;
    BOOL shouldAllowSearchBarEditing;
}

/** 单利 */
instance_implementation(HNSearchViewController)


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  显示搜索界面
 */
- (void)showInViewController:(UIViewController *)controller fromSearchBar:(UISearchBar *)_fromSearchBar {
    if (!controller.navigationController)return;
    
    willShowSearchResultController = YES;
    SAFE_SEND_MESSAGE(self.searchResultController, shouldShowSearchResultControllerBeforePresentation) {
        willShowSearchResultController = [self.searchResultController shouldShowSearchResultControllerBeforePresentation];
    }
    
    shouldHideSearchResultWhenNoSearch = NO;
    SAFE_SEND_MESSAGE(self.searchResultController, shouldHideSearchResultControllerWhenNoSearch) {
        shouldHideSearchResultWhenNoSearch = [self.searchResultController shouldHideSearchResultControllerWhenNoSearch];
    }
    
    fromSearchBar = _fromSearchBar;
    originStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    
    fromSearchBarFrame = [fromSearchBar convertRect:fromSearchBar.bounds toView:[HNUtils currentWindow]];
//    self.toNavigationBarView.frame = CGRectMake(0, 0, ScreenWidth, CGRectGetMaxY(fromSearchBarFrame));
//    self.toNavigationBarView.backgroundColor = fromSearchBar.barTintColor;
//    
//    CGRect frame = fromSearchBar.frame;
//    frame.origin.x = 0;
//    frame.origin.y = CGRectGetHeight(self.toNavigationBarView.frame) - CGRectGetHeight(fromSearchBar.frame);
//    self.searchBar.frame = frame;
//    self.searchBar.placeholder = fromSearchBar.placeholder;
//    
//    self.fromNavigationBarView = [controller.navigationController.navigationBar resizableSnapshotViewFromRect:CGRectMake(0, -20, SCREEN_WIDTH, 64) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
//    [self.view addSubview:self.fromNavigationBarView];
//    
//    searchResultView = nil;
//    if (willShowSearchResultController) {
//        [self addSearchResultController];
//    }
//    
//    targetStatusBarStyle = controller.preferredStatusBarStyle;
//    
//    UIViewController *targetController = self.navigationController ? self.navigationController : self;
//    targetController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    targetController.modalPresentationCapturesStatusBarAppearance = YES;
//    [controller.navigationController presentViewController:targetController animated:NO completion:^{
//        [self show];
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
