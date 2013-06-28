//
//  ViewController.h
//  CoreTextDemo
//
//  Created by doujingxuan on 13-6-27.
//  Copyright (c) 2013年 SpriteApp Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSCoreTextView.h"

@interface ViewController : UIViewController
{
  IBOutlet   KSCoreTextView * _coreTextView;
  IBOutlet   UIScrollView * _scrollView;
}
@property (nonatomic,assign)CGFloat fontSize;
@end
