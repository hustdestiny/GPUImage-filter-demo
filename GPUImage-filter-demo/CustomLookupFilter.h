//
//  CustomLookupFilter.h
//  GPUImage-filter-demo
//
//  Created by zhouxin on 2018/6/5.
//  Copyright © 2018年 zhouxin. All rights reserved.
//

#import "GPUImageFilterGroup.h"
#import <GPUImage.h>

@interface CustomLookupFilter : GPUImageFilterGroup
{
    GPUImagePicture *lookupImageSource;
}

- (id)initWithLookupName: (NSString *)lookupName;

@end
