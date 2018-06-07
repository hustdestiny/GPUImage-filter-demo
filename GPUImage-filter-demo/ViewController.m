//
//  ViewController.m
//  GPUImage-filter-demo
//
//  Created by zhouxin on 2018/5/25.
//  Copyright © 2018年 zhouxin. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>
#import "CustomLookupFilter.h"
#import "Custom256LookupFilter.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *srcView;
@property (nonatomic, strong) UIImageView *filterView;

@property (nonatomic, strong) GPUImageFilterGroup *filter;
@property (nonatomic, strong) GPUImagePicture *picture;
@property (nonatomic, strong) GPUImagePicture *lookup;
@end

@implementation ViewController
- (UIImageView *)srcView {
    if (!_srcView) {
        _srcView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _srcView.contentMode = UIViewContentModeScaleAspectFit;
        _srcView.backgroundColor = [UIColor blackColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.text = @"src";
        label.textColor = [UIColor whiteColor];
        [_srcView addSubview:label];
    }
    return _srcView;
}

- (UIImageView *)filterView {
    if (!_filterView) {
        _filterView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _filterView.contentMode = UIViewContentModeScaleAspectFit;
        _filterView.backgroundColor = [UIColor blackColor];
    }
    return _filterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imageName = @"sample.jpg";
    [self.view addSubview:self.srcView];
    self.srcView.image = [UIImage imageNamed:imageName];
    [self.view addSubview:self.filterView];
    
    self.picture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:imageName]];
    self.filter = [[CustomLookupFilter alloc] initWithLookupName:@"PARI_01.jpg"];
    [self.picture addTarget:self.filter];
    [self.picture processImageUpToFilter:self.filter withCompletionHandler:^(UIImage *processedImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.filterView.image = processedImage;
            NSLog(@"%@", processedImage);
        });
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view bringSubviewToFront:self.srcView];
    self.filterView.hidden = YES;
    self.srcView.hidden = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.view bringSubviewToFront:self.filterView];
    self.srcView.hidden = YES;
    self.filterView.hidden = NO;
}


@end
