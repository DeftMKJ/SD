//
//  ViewController.m
//  变异版本的SDScrollView
//
//  Created by 宓珂璟 on 16/6/4.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "ViewController.h"
#import <SDCycleScrollView.h>
#import "UIImage+ImageCompress.h"
#import <Masonry.h>
@interface ViewController () <UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic,strong) UIView *containerBackView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets =  NO;
    NSArray *images = @[@"http://twt.img.iwala.net/upload/118c59e1b27fd575.jpg",
                        @"http://twt.img.iwala.net/upload/357797c67b3f7033.jpg",
                        @"http://twt.img.iwala.net/upload/a9a69883ba624e67.jpg",
                        @"http://twt.img.iwala.net/upload/858913320bff6162.jpg",
                        @"http://twt.img.iwala.net/upload/21359667942b4065.jpg",
                        @"http://twt.img.iwala.net/upload/93f0689ec10d5033.jpg"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 66;
    self.tableView.delegate = self;
    
    UIView *headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 150)];
    self.tableView.tableHeaderView = headBackView;
    self.containerBackView = headBackView;
    
    self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    // 一个Category给用颜色做ImageView 用15宽2高做一个长方形图片 当前图片
    self.bannerView.currentPageDotImage = [UIImage imageWithColor:[UIColor redColor] forSize:CGSizeMake(15, 2)];
    // 同上做一个 其他图片
    self.bannerView.pageDotImage = [UIImage imageWithColor:[UIColor whiteColor] forSize:CGSizeMake(15, 2)];
    // 加载网络数组图片 我个人认为这个就有点坑了，理论上这里只能给网络加载的图片实现轮播，但是如果你要DIY一些图片上的文字，就要修改源码了
    self.bannerView.imageURLStringsGroup = images;
    // 每张图对应的文字数组
    //self.bannerView.titlesGroup = @[@"第一张",@"第二章",@"第三章",@"第四章",@"第五章"];
    // 加载本地图片
    //self.bannerView.localizationImageNamesGroup = @[放本地图片];
    //默认两秒 自动滚动时间
    //self.bannerView.autoScrollTimeInterval = 5.0f;
    // 是否无限滚动 默认YES
    //self.bannerView.infiniteLoop = YES;
    // 是否自动滚动 是否自动滚动 默认YES
    //self.bannerView.autoScroll = YES;
    // 滚动方向 默认水平
    //self.bannerView.scrollDirection = UICollectionViewScrollDirectionVertical;
    [headBackView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headBackView);
    }];
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 300, 375, 100) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = @[@"第一张",@"第二章",@"第三章",@"第四章",@"第五章"];
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.imageURLStringsGroup = images;
    [self.view addSubview:cycleScrollView2];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 500, 375, 120) shouldInfiniteLoop:YES imageNamesGroup:images];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.needMask = YES;
    cycleScrollView.countryNames = @[@"澳大利亚",@"新加坡",@"马来西亚",@"吉尔吉斯斯坦",@"朝鲜",@"USA"];
    cycleScrollView.countryNumbers = @[@"23232",@"535",@"5656",@"5656",@"42312",@"312312"];
    [self.view addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"MKJ";
    cell.detailTextLabel.text = @"一周可以突破10000";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >=0) {
        offsetY = 0;
    }
    [self.bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerBackView).with.offset(offsetY);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
