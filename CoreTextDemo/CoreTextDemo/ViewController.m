//
//  ViewController.m
//  CoreTextDemo
//
//  Created by doujingxuan on 13-6-27.
//  Copyright (c) 2013年 SpriteApp Inc. All rights reserved.
//

#import "ViewController.h"

#define PADDING_LEFT 10.0
#define PADDING_TOP 10.0

@interface ViewController ()

@end

@implementation ViewController
@synthesize fontSize;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.fontSize = 24.0;
    
    NSLog(@"_coreTextView is %@",NSStringFromCGRect(_coreTextView.frame));
    NSLog(@"self.view is %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"_scroolview is %@",NSStringFromCGRect(_scrollView.frame));
    
    _coreTextView.fontName = @"Helvetica";
    _coreTextView.fontSize = self.fontSize;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"sampleText" ofType:@"txt"];
    NSLog(@"path is %@",path);
   NSString * tempString =  [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    

    _coreTextView.text = tempString;
	[self updateKSCoreText];
    
    UIBarButtonItem * rightButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFontSize)] autorelease];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem * leftButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(delFontSize)] autorelease];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}
-(void)addFontSize
{
    self.fontSize +=4.0;
    [self updateKSCoreText];
}
-(void)delFontSize
{
    self.fontSize -=4.0;
    [self updateKSCoreText];
}

-(void)updateKSCoreText
{
    _coreTextView.fontSize = self.fontSize;
    [_coreTextView buildTextView];
    
    [_coreTextView setNeedsDisplay];
    NSLog(@"_coreTextView is %@",NSStringFromCGRect(_coreTextView.frame));
    
	_scrollView.contentSize = CGSizeMake(self.view.frame.size.width,_coreTextView.frame.size.height);
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
	/* build text
	 use dumb multithreading */
}

- (void)firstUpdate {
	/* very very dumb multithreading */
	/* i know, it's lame! */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
