//
//  CustomLookupFilter.m
//  GPUImage-filter-demo
//
//  Created by zhouxin on 2018/6/5.
//  Copyright © 2018年 zhouxin. All rights reserved.
//

#import "CustomLookupFilter.h"
#import "GPUImagePicture.h"
#import "Custom256LookupFilter.h"

@implementation CustomLookupFilter
- (id)initWithLookupName: (NSString *)lookupName;
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    UIImage *image = [UIImage imageNamed:lookupName];
    
    lookupImageSource = [[GPUImagePicture alloc] initWithImage:image];
    Custom256LookupFilter *lookupFilter = [[Custom256LookupFilter alloc] init];
    [self addFilter:lookupFilter];
    
    [lookupImageSource addTarget:lookupFilter atTextureLocation:1];
    [lookupImageSource processImage];
    
    self.initialFilters = [NSArray arrayWithObjects:lookupFilter, nil];
    self.terminalFilter = lookupFilter;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

@end

