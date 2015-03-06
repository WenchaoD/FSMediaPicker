//
//  FSViewController.h
//  FSMediaPicker
//
//  Created by Wenchao Ding on 03/02/2015.
//  Copyright (c) 2014 Wenchao Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIView *movieContainer;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mediaTypeControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editModeControl;

- (IBAction)showClicked:(id)sender;

@end
