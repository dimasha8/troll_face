//
//  ViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "ViewController.h"

#import "TFCreateNewViewController.h"
#import "TFImageBrowseViewController.h"
#import "TFSettingsViewController.h"
#import "TFHelpViewController.h"

@interface ViewController ()
- (IBAction)navigationButtonPressed:(UIButton *)pSender;
@end

@implementation ViewController

#pragma mark - Life cicle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB actions
- (IBAction)navigationButtonPressed:(UIButton *)pSender {
    switch (pSender.tag) {
        case 0: //Create new button
            
            break;
            
        case 1://show created mems button
            
            break;
            
        case 2://settings button
            
            break;
            
        case 3://help button
            
            break;
            
        default:
            break;
    }
}

@end
