//
//  Custom256LookupFilter.h
//  ImageFilter
//
//  Created by zhouxin on 2018/6/6.
//  Copyright © 2018年 CrazySurfboy. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface Custom256LookupFilter : GPUImageTwoInputFilter
{
    GLint intensityUniform;
}

@property(readwrite, nonatomic) CGFloat intensity;
@end
