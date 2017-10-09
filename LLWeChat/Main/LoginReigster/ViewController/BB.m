
//
//  BB.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "BB.h"
#import "CC.h"
#import "PresentTransition.h"

@interface BB ()<photoBrowserAnimatorPresentDelegate>

@property (nonatomic, strong) PresentTransition *animator;

@end

@implementation BB

#pragma amrk - 懒加载
- (PresentTransition *)animator{
    if(!_animator){
        _animator = [[PresentTransition alloc] init];
    }
    return _animator;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
   
    
    UIButton  *bt =[[UIButton alloc]initWithFrame:CGRectMake(30, 150, 200, 60)];
    bt.backgroundColor = [UIColor yellowColor];
    [bt addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bt];
}




    



- (void)gotoNext{
    CC  *vc = [CC new];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    
    vc.transitioningDelegate = self.animator;
    
    self.animator.animationPresentDelegate = self;
    self.animator.animationDismissDelegate = vc;

    [self presentViewController:vc animated:YES completion:nil];
}



- (CGRect)startRect:(NSInteger)index{
    return CGRectMake(20, 50, 50, 50);
}

- (CGRect)endRect:(NSInteger)index{
    return CGRectMake(0, 0, 300, 500);
}

- (UIImageView *)locImageView:(NSInteger)index{
    
    UIImageView  *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_app"]];
    
    return image;
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
