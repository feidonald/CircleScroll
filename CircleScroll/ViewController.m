//
//  ViewController.m
//  CircleScroll
//
//  Created by 丁飞 on 17/5/27.
//  Copyright © 2017年 XOX. All rights reserved.
//

#import "ViewController.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController
{
    UIScrollView *scrollView;  
    NSMutableArray *scrViewArray;  //存放显示的三个不同视图
    BOOL kIsScrolling;  //滑太快会Bug 加判断
}
- (void)viewDidLoad {
    [super viewDidLoad];
    kIsScrolling = NO;
    scrViewArray = [NSMutableArray array];
    NSMutableArray *colorArray = [NSMutableArray arrayWithObjects:[UIColor redColor],[UIColor greenColor],[UIColor yellowColor], nil];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"3",@"1",@"2", nil];
    for (int i = 0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, 200)];
        label.backgroundColor = colorArray[i];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:24];
        label.textAlignment = NSTextAlignmentCenter;
        [scrViewArray addObject:label];
    }
    [self setScroViewWithArray:scrViewArray];
}

- (void)setScroViewWithArray:(NSMutableArray *)array{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 200)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    for (int i = 0; i<array.count; i++) {
        UILabel *label = array[i];
        label.frame = CGRectMake(i*WIDTH, 0, WIDTH, 200);
        [scrollView addSubview:label];
    }
    [scrollView setBounces:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setPagingEnabled:YES];
    scrollView.contentSize = CGSizeMake(WIDTH*array.count, 200);
    scrollView.contentOffset = CGPointMake(WIDTH, 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollViewa{
    
    if (scrollView.contentOffset.x == WIDTH || kIsScrolling){
        return;
    }
    kIsScrolling = YES;
    NSMutableArray *oldArray = [NSMutableArray arrayWithArray:scrViewArray];
    scrViewArray = [NSMutableArray array];
    //向右边滑
    if (scrollView.contentOffset.x == 2*WIDTH) {
        [scrViewArray addObject:oldArray[1]];
        [scrViewArray addObject:oldArray[2]];
        [scrViewArray addObject:oldArray[0]];
    }else if (scrollView.contentOffset.x == 0){
        [scrViewArray addObject:oldArray[2]];
        [scrViewArray addObject:oldArray[0]];
        [scrViewArray addObject:oldArray[1]];
    }
    [self setScroViewWithArray:scrViewArray];
        //向左边滑
    kIsScrolling = NO;
}


@end
