//
//  KSCoreTextView.h
//  CoreTextDemo
//
//  Created by doujingxuan on 13-6-27.
//  Copyright (c) 2013年 SpriteApp Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface KSCoreTextView : UIView
{
    CFMutableAttributedStringRef _attrString;
}
@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,readonly) CGFloat height;
@property (nonatomic,retain)NSString * fontName;
@property (nonatomic,retain)NSString * text;

- (void)calculateHeight;
- (void)buildText;
- (void)buildTextView;
@end
