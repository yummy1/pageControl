//
//  ViewController.m
//  page
//
//  Created by 毛毛 on 16/4/13.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "ViewController.h"
#import "MaomaoSegmentedControl.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define self_Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define self_Height CGRectGetHeight([UIScreen mainScreen].bounds)
@interface ViewController ()<MaomaoSegmentedControlDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *mainScrollView; /**< 正文mainSV */
@property (nonatomic ,strong)MaomaoSegmentedControl * scrollview; /**< LFLuisement */
@property (nonatomic, strong)NSArray *array;
@end

@implementation ViewController

- (NSArray *)array
{
    if (!_array) {
        _array = @[@"女装",@"内衣",@"鞋品",@"箱包",@"居家",@"家纺家装",@"数码家电",@"美妆配饰",@"美食",@"中老年",@"文娱运动",@"儿童",@"母婴",@"男装"];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //    1.初次创建：
    _scrollview=[[MaomaoSegmentedControl alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    _scrollview.delegate = self;
    //   2.设置显示切换标题数组
    [_scrollview AddSegumentArray:self.array];
    //   default Select the Button
    [_scrollview selectTheSegument:0];
    _scrollview.selectColor = [UIColor redColor];
    [self.view addSubview:_scrollview];
    
    [self createMainScrollView];

}
//创建正文ScrollView内容
- (void)createMainScrollView {
    CGFloat begainScrollViewY = 37+ 64;
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, begainScrollViewY, self_Width,(self_Height -begainScrollViewY))];
    self.mainScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.bounces = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(self_Width * self.array.count, (self_Height -begainScrollViewY));
    //设置代理
    self.mainScrollView.delegate = self;
    
    //添加滚动显示的对应的界面view
    for (int i = 0; i < self.array.count; i++) {
        UIView *viewExample = [[UIView alloc]initWithFrame:CGRectMake(self_Width *i, 0, self_Width,self_Height)];
        viewExample.backgroundColor = RandColor;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self_Width/2 -20, self_Height -10, 40, 20)];
        [button setTitle:@"毛毛" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [viewExample addSubview:button];
        [self.mainScrollView addSubview:viewExample];
    }
}

#pragma mark --- UIScrollView代理方法

static NSInteger pageNumber = 0;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    pageNumber = (int)(scrollView.contentOffset.x / self_Width + 0.5);
    //    滑动SV里视图,切换标题
    [_scrollview selectTheSegument:pageNumber];
    
}

#pragma mark ---LFLUISegmentedControlDelegate
/**
 *  点击标题按钮
 *
 *  @param selection 对应下标 begain 0
 */
-(void)uisegumentSelectionChange:(NSInteger)selection selectedBtn:(UIButton *)button{
    //    加入动画,显得不太过于生硬切换
    [UIView animateWithDuration:.2 animations:^{
        [self.mainScrollView setContentOffset:CGPointMake(self_Width *selection, 0)];
    }];
    [self.mainScrollView setContentOffset:CGPointMake(button.frame.origin.x, button.frame.origin.y)];
}



@end
