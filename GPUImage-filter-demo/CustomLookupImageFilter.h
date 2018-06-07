//
//  CustomLookupImageFilter.h
//  GPUImage-filter-demo
//
//  Created by zhouxin on 2018/5/25.
//  Copyright © 2018年 zhouxin. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@class GPUImagePicture;
@interface CustomLookupImageFilter : GPUImageFilterGroup
{
    GPUImagePicture *lookupImageSource;
}
- (instancetype)initWithLookupName: (NSString *)lookup;

@end
