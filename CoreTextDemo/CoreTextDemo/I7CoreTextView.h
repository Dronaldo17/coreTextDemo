//
//  I7CoreTextView.h
//  CoreTextExample
//
//  Created by Jonas Schnelli on 18.05.10.
//  Copyright 2010 include7 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>


enum I7CoreTextViewTextType {
	I7CoreTextViewTextTypeFonts,
	I7CoreTextViewTextTypeParagraph
};

@interface I7CoreTextView : UIView {
	CFMutableArrayRef fontsMutable;
	CGFloat _fontSize;
	CGFloat _height;
	CFMutableAttributedStringRef _attrString;
    
    NSString * _fontName;
    NSString * _text;
}

@property (assign) CGFloat fontSize;
@property (assign) enum I7CoreTextViewTextType textType;
@property (readonly) CGFloat height;
@property (nonatomic,retain)NSString * fontName;
@property (nonatomic,retain)NSString * text;

- (void)loadMutableFonts;
- (void)calculateHeight;
- (void)buildText;
- (void)localInit;

-(void)loadLocalTextFromPath:(NSString*)path;
-(id)initWithFontName:(NSString*)fontName WithText:(NSString*)text  fontSize:(CGFloat)foneSize;
-(void)buildTextView;

@end
