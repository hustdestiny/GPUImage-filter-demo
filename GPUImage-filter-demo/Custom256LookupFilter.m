//
//  Custom256LookupFilter.m
//  ImageFilter
//
//  Created by zhouxin on 2018/6/6.
//  Copyright © 2018年 CrazySurfboy. All rights reserved.
//

#import "Custom256LookupFilter.h"

NSString *const kGPUImage16LookupFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2; // TODO: This is not used
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2; // lookup texture
 
 uniform lowp float intensity;
 
 const lowp float table = 16.0;
 
 void main()
 {
     highp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     
     highp float blueColor = textureColor.b * (table * table - 1.0);
     
     highp vec2 quad1;
     quad1.y = floor(floor(blueColor) / table);
     quad1.x = floor(blueColor) - (quad1.y * table);
     
     highp vec2 quad2;
     quad2.y = floor(ceil(blueColor) / table);
     quad2.x = ceil(blueColor) - (quad2.y * table);
     
     highp vec2 texPos1;
     texPos1.x = (quad1.x * 1.0/table) + 0.5/512.0 + ((1.0/table - 1.0/512.0) * textureColor.r);
     texPos1.y = (quad1.y * 1.0/table) + 0.5/512.0 + ((1.0/table - 1.0/512.0) * textureColor.g);
     
     highp vec2 texPos2;
     texPos2.x = (quad2.x * 1.0/table) + 0.5/512.0 + ((1.0/table - 1.0/512.0) * textureColor.r);
     texPos2.y = (quad2.y * 1.0/table) + 0.5/512.0 + ((1.0/table - 1.0/512.0) * textureColor.g);
     
     lowp vec4 newColor1 = texture2D(inputImageTexture2, texPos1);
     lowp vec4 newColor2 = texture2D(inputImageTexture2, texPos2);
     
     lowp vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
     gl_FragColor = mix(textureColor, vec4(newColor.rgb, textureColor.w), intensity);
 }
 );

@implementation Custom256LookupFilter

@synthesize intensity = _intensity;

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    intensityUniform = [filterProgram uniformIndex:@"intensity"];
    self.intensity = 1.0f;
    
    if (!(self = [super initWithFragmentShaderFromString:kGPUImage16LookupFragmentShaderString]))
    {
        return nil;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setIntensity:(CGFloat)intensity
{
    _intensity = intensity;
    
    [self setFloat:_intensity forUniform:intensityUniform program:filterProgram];
}

@end
