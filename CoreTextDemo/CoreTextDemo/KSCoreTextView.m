//
//  KSCoreTextView.m
//  CoreTextDemo
//
//  Created by doujingxuan on 13-6-27.
//  Copyright (c) 2013年 SpriteApp Inc. All rights reserved.
//

#import "KSCoreTextView.h"
#import <QuartzCore/QuartzCore.h>

#define PADDING_LEFT 10.0
#define PADDING_TOP 10.0

@implementation KSCoreTextView

@synthesize fontName,fontSize,text,height;
- (void)dealloc
{
    if (_attrString) {
        CFRelease(_attrString);
    }
    self.fontName = nil;
    self.text = nil;
    [super dealloc];
}
- (void)awakeFromNib {
	/* this will ensure that the layer will be redrawn when the user changes the autorotation */
	CALayer *layer = self.layer;
	[layer setNeedsDisplayOnBoundsChange:YES];
}
//-(id)initWithFontName:(NSString*)fontName WithText:(NSString*)text  fontSize:(CGFloat)foneSize
//{
//    self = [super init];
//    if (self) {
//        if (nil != fontName) {
//            self.fontName = fontName;
//        }
//        if (nil != text) {
//            self.text = text;
//        }
//        _fontSize = foneSize;
//    }
//    return self;
//}
- (void)localInit {
	[self buildText];
	[self calculateHeight];
}
-(void)buildTextView
{
    [self buildText];
    [self calculateHeight];
}

- (void)calculateHeight {
    
	/* this methode will get the text height and change the frame size of self (the view) */
	
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(_attrString);
	
	CFRange fitRange = CFRangeMake(0,0);
	CGSize aSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, CFStringGetLength((CFStringRef)_attrString)), NULL, CGSizeMake(self.frame.size.width,CGFLOAT_MAX), &fitRange);
    
    CFRelease(framesetter);
	
	self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,aSize.height+PADDING_TOP+PADDING_TOP);
}
- (void)buildText {
	/* build the text */
	
	if(_attrString) {
		CFRelease(_attrString);
	}
	_attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
	
    CFAttributedStringReplaceString (_attrString, CFRangeMake(0, 0), (CFStringRef)self.text);
    
    CFStringRef cfFontName = (CFStringRef)self.fontName;
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)cfFontName, self.fontSize, NULL);
    CFAttributedStringSetAttribute(_attrString, CFRangeMake(0, CFStringGetLength((CFStringRef)_attrString)), kCTFontAttributeName, myFont);
    CFRelease(myFont);
    
	CTTextAlignment alignment = kCTLeftTextAlignment;
	CTParagraphStyleSetting settings[] = {
		{kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment}
	};
	CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
	CFAttributedStringSetAttribute(_attrString, CFRangeMake(0, CFStringGetLength((CFStringRef)_attrString)), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
}

- (void) drawRect:(CGRect)rect {
	/* draw it */
	
	if(!_attrString) {
		[self buildText];
	}
    
	/* get the context */
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	
	/* flip the coordinate system */
	
	float viewHeight = self.bounds.size.height;
    CGContextTranslateCTM(context, 0, viewHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
	CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, 1.0));
	
	
	/* generate the path for the text */
	CGMutablePathRef path = CGPathCreateMutable();
//	CGRect bounds = CGRectMake(rect.origin.x, rect.origin.y, self.bounds.size.width-20.0, self.bounds.size.height);
	CGPathAddRect(path, NULL, rect);
	
	
	
	/* draw the text */
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(_attrString);
	CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
												CFRangeMake(0, 0), path, NULL);
	CFRelease(framesetter);
	CFRelease(path);
	CTFrameDraw(frame, context);
    CFRelease(frame);
}
@end
