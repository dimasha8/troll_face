//
//  ViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "ViewController.h"
#import "TFImageBrowseViewController.h"
#import "TFSettingsViewController.h"
#import "TFHelpViewController.h"
#import "TFMainWorkFieldViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life cicle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Modify buttons' style in circle menu
    for (UIButton * button in [self.menu subviews]){
        [button setAlpha:.95f];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KYCircleMenu Button Action

// Run button action depend on their tags:
//
// TAG:        1       1   2      1   2     1   2     1 2 3     1 2 3
//            \|/       \|/        \|/       \|/       \|/       \|/
// COUNT: 1) --|--  2) --|--   3) --|--  4) --|--  5) --|--  6) --|--
//            /|\       /|\        /|\       /|\       /|\       /|\
// TAG:                             3       3   4     4   5     4 5 6
//
- (void)runButtonActions:(id)sender {
    [super runButtonActions:sender];
    
    // Configure new view & push it with custom |pushViewController:| method
    UIViewController * lViewController = [self goToControllerAtIndex:[sender tag]];
    // Use KYCircleMenu's |-pushViewController:| to push vc
    if(lViewController != nil) {
        [self pushViewController:lViewController];
    }
}

- (id)goToControllerAtIndex:(NSInteger)pIndex {
    TFAbstractViewController *lController = nil;
    switch (pIndex) {
        case 1: {//Create new button
            lController = [[TFMainWorkFieldViewController alloc] initWithNibName:@"TFMainWorkFieldViewController" bundle:nil];
            lController.arcTabBar = self.arcTabBar;
            break;
        }
        case 2: {//show created mems button
            lController = [[TFImageBrowseViewController alloc] initWithNibName:@"TFImageBrowseViewController" bundle:nil];
            break;
        }
        case 3: {//settings button
            lController = [[TFSettingsViewController alloc] initWithNibName:@"TFSettingsViewController" bundle:nil];
            break;
        }
        case 4: {//help button
            lController = [[TFHelpViewController alloc] initWithNibName:@"TFHelpViewController" bundle:nil];
            break;
        }
        case 5:{

            break;
        }
        case 6:{
            
            break;
        }
        default:
            break;
    }
    
    return lController;
}

@end
