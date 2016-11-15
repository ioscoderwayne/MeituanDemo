//
//  XYHomeViewController.m
//  仿美团外卖首页效果
//
//  Created by weixiaoyang on 2016/11/15.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "XYHomeViewController.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "XYSecondViewController.h"
#import "UIView+Frame.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface XYHomeViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>
/**  自定义导航  **/
@property (nonatomic,weak) UIView *customNav;
/**  scrollView  **/
@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UISearchBar *searchBr;

@property (nonatomic,weak) UIButton *addressBtn;

@property (nonatomic,weak) UIButton *rightSearchBtn;



@end

@implementation XYHomeViewController

-(UISearchBar *)searchBr
{
    if (_searchBr == nil) {
       UISearchBar * searchBr = [[UISearchBar alloc]init];
        searchBr.placeholder = @"输入商家或商品名称";
        searchBr.width = kScreenW -20;
        searchBr.height = 25;
        searchBr.x = kScreenW;
        searchBr.centerY = self.customNav.centerY;
        [searchBr setBackgroundImage:[UIImage new]];
        searchBr.layer.cornerRadius = 10;
        searchBr.layer.masksToBounds = YES;
        
        [self.customNav addSubview:searchBr];
        _searchBr = searchBr;
    }
    
    return _searchBr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 初始化scrollView
    [self setupScrollView];
    
    // 2.图片轮播器 并添加图片轮播在最顶部
    [self setupBannerView];
    
    // 3.初始化导航栏
    [self setupNavBar];
    
    //4. 测试导航栏跳转
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 230, 200, 40);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"点我试试跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];

}

/**
 *  跳转
 */
-(void)pushBtnClicked
{
    XYSecondViewController *secondVc = [[XYSecondViewController alloc]init];
    
    [self.navigationController pushViewController:secondVc animated:YES];
}

/**
 *  初始化导航栏
 */
-(void)setupNavBar
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    UIView *customNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    customNav.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.0];
    //添加按钮显示定位位置
    UIButton *adrressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    adrressBtn.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
    [adrressBtn setTitle:@"望京国际研发园" forState:UIControlStateNormal];
    adrressBtn.size = CGSizeMake(120, 25);
    adrressBtn.layer.cornerRadius = 10;
    adrressBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    adrressBtn.centerX = kScreenW*0.5;
    adrressBtn.centerY = customNav.height*0.5;
    [customNav addSubview:adrressBtn];
    self.addressBtn = adrressBtn;
//    self.navigationController.navigationItem.titleView = adrressBtn;
    //右侧搜索按钮
    UIButton *rightSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSearchBtn.size = CGSizeMake(60, 25);
    rightSearchBtn.layer.cornerRadius = 10;
    rightSearchBtn.x = kScreenW - 80;
    rightSearchBtn.y = adrressBtn.y;
    rightSearchBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [rightSearchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    rightSearchBtn.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
    [customNav addSubview:rightSearchBtn];
    self.rightSearchBtn = rightSearchBtn;
    [self.view addSubview:customNav];
    
    self.customNav = customNav;

}
/**
 *  初始scrollView
 */

-(void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenW, 1000);
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
}
/**
 *  初始图片轮播器
 */
-(void)setupBannerView
{
    //图片
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    CGFloat height = 200;
    CGRect frame = CGRectMake(0, 0, kScreenW, height);
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
//    //标题
//    NSArray *titles = @[@"新建交流QQ群：185534916 ",
//                        @"感谢您的支持，如果下载的",
//                        @"如果代码在使用过程中出现问题",
//                        @"您可以发邮件到gsdios@126.com"
//                        ];
//    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.scrollView addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;

}

-(void)loadNewData
{
    NSLog(@"==%s",__func__);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scrollView.mj_header endRefreshing];
    });
}

#pragma mark - SDCycleScrollViewDelegate
/**
 *  点击对应图片
 */
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"===%f",scrollView.contentOffset.y);
    
    CGFloat alpha = scrollView.contentOffset.y/120;
    
    self.customNav.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:alpha];
    
    if (alpha >= 0.8) {
        [UIView animateWithDuration:0.25 animations:^{
            self.searchBr.x = 10;
            self.rightSearchBtn.hidden = YES;
            self.addressBtn.hidden = YES;
        }];
    }
    
    if (alpha <= 0.2) {
        [UIView animateWithDuration:0.25 animations:^{
            self.searchBr.x = kScreenW;
            self.rightSearchBtn.hidden = NO;
            self.addressBtn.hidden = NO;
        }];
    }
    
    if (scrollView.contentOffset.y < 0) {
        self.rightSearchBtn.hidden = YES;
        self.addressBtn.hidden = YES;
    }
}
@end
