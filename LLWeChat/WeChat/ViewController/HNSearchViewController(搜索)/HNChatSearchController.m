//
//  HNChatSearchController.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 搜索结果 控制器 **************/

#import "HNChatSearchController.h"
#import "HNMessageSearchResultModel.h"

@interface HNChatSearchController ()

/*** view 属性 ***/
@property (nonatomic, strong) UIButton          *friendBtn;         // 朋友圈
@property (nonatomic, strong) UIButton          *articleBtn;         // 文章
@property (nonatomic, strong) UIButton          *publicSignBtn;      // 公众号


@property (nonatomic, strong) UIButton          *backButton;

@property (nonatomic, strong) HNSearchBar       *searchBar;
@property (nonatomic, assign) BOOL              isTransitioning;
@property (nonatomic, strong) UIViewController  *subSearchController;
@property (nonatomic, strong) UIView            *searchResultView;
@property (nonatomic, strong) UILabel           *searchResultLabel;
@property (nonatomic, strong) UITableView       *chatHistoryTableView;

@property (nonatomic, copy  ) NSArray<NSArray<HNMessageSearchResultModel *> *> *searchResultArray;

@property (nonatomic, strong) NSString          *searchText;
@end

@implementation HNChatSearchController
{
    CGFloat searchBarMinWidth;
    UIColor *searchBarBackgroundColor;
    UIColor *searchBarTintColor;
    CGSize searchBarLeftViewSize;
    UIView *blockView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRGB(233, 233, 233);

    [self createView];
    [self addFrame];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

#pragma mark ---------------- CreateViewAndAddFrame ----------------

//加载view
- (void)createView{
    [self.view addSubview:self.friendBtn];
    [self.view addSubview:self.articleBtn];
    [self.view addSubview:self.publicSignBtn];
}

- (void)addFrame{
    CGFloat  k = (ScreenWidth - 3*ScaleWidth(74))*0.25;
    _friendBtn.frame = CGRectMake(k, ScaleHeight(55), ScaleWidth(74), ScaleWidth(74));
    _articleBtn.frame = CGRectMake(_friendBtn.right +k, ScaleHeight(55), ScaleWidth(74), ScaleWidth(74));
    _publicSignBtn.frame = CGRectMake(_articleBtn.right + k, ScaleHeight(55), ScaleWidth(74), ScaleWidth(74));
}


#pragma  ---  private menthod ----

// 前往朋友圈
- (void)gotoFriendCircleClick:(UIButton*)sender{


}

// 前往文章
- (void)gotoArticleClick:(UIButton*)sender{
    
    
}

// 前往公众号
- (void)gotoPublicSignClick:(UIButton*)sender{
    
    
}


- (void)tapHandler:(UITapGestureRecognizer *)tap {
    if (self.searchResultView.hidden)
        [self.searchViewController dismissKeyboard];
}


- (void)searchCancelButtonDidTapped {
    HNSearchBar *searchBar =  self.searchViewController.searchBar;
    if (_backButton.superview) {
        [_backButton removeFromSuperview];
    }
    
    if (_subSearchController) {
        [_subSearchController.view removeFromSuperview];
        [_subSearchController removeFromParentViewController];
        _subSearchController = nil;
    }
    
    CGRect frame = searchBar.frame;
    frame.origin.x = 0;
    frame.size.width = SCREEN_WIDTH;
    searchBar.frame = frame;
    
    searchBar.placeholder = @"搜索";
    searchBar.text = nil;
    [searchBar setImage:nil forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
}



#pragma mark ----------------------- 懒加载 --------------------
/*** view 属性 ***/
// 朋友圈
- (UIButton*)friendBtn{
    if (!_friendBtn) {
        _friendBtn = [[UIButton alloc]init];
        [_friendBtn addTarget:self action:@selector(gotoFriendCircleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_friendBtn setImage:[UIImage imageNamed:@"fts_edu_sns_icon"] forState:UIControlStateNormal];
        [_friendBtn setBackgroundImage:[UIImage imageNamed:@"fts_edu_button_bkg_normal"] forState:UIControlStateNormal];
    }
    return _friendBtn;
}

// 文章
- (UIButton*)articleBtn{
    if (!_articleBtn) {
        _articleBtn = [[UIButton alloc]init];
        [_articleBtn addTarget:self action:@selector(gotoArticleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_articleBtn setImage:[UIImage imageNamed:@"fts_edu_article_icon"] forState:UIControlStateNormal];
        [_articleBtn setBackgroundImage:[UIImage imageNamed:@"fts_edu_button_bkg_normal"] forState:UIControlStateNormal];
    }
    return _articleBtn;
}

// 公众号
- (UIButton*)publicSignBtn{
    if (!_publicSignBtn) {
        _publicSignBtn = [[UIButton alloc]init];
        [_publicSignBtn addTarget:self action:@selector(gotoPublicSignClick:) forControlEvents:UIControlEventTouchUpInside];
        [_publicSignBtn setImage:[UIImage imageNamed:@"fts_edu_brandcontact_icon"] forState:UIControlStateNormal];
        [_friendBtn setBackgroundImage:[UIImage imageNamed:@"fts_edu_button_bkg_normal"] forState:UIControlStateNormal];
    }
    return _publicSignBtn;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
