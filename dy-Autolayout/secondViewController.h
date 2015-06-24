//
//  secondViewController.h
//  dy-Autolayout
//
//  Created by jzb_iOS on 15/6/15.
//  Copyright (c) 2015年 jzb_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)action:(id)sender;
- (IBAction)scanerButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
