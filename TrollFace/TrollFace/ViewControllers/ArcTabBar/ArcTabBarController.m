//
//  ArcTabBarController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/22/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "ArcTabBarController.h"

#import "ViewController.h"
#import "TFSettingsViewController.h"
#import "TFImageBrowseViewController.h"
#import "TFHelpViewController.h"

@interface ArcTabBarController ()

@end

@implementation ArcTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override

// Override |KYArcTabViewController|'s |-setup|
- (void)setup {
    // Set View Frame
    self.viewFrame = (CGRect){CGPointZero, {CGRectGetWidth([UIScreen mainScreen].applicationFrame), CGRectGetHeight([UIScreen mainScreen].applicationFrame)}};
    
    // Add child view controllers to each tab
    //main(first) controller
    ViewController *lMainView  = [[ViewController alloc] initWithButtonCount:kKYCCircleMenuButtonsCount
                                                                    menuSize:kKYCircleMenuSize
                                                                  buttonSize:kKYCircleMenuButtonSize
                                                       buttonImageNameFormat:kKYICircleMenuButtonImageNameFormat
                                                            centerButtonSize:kKYCircleMenuCenterButtonSize
                                                       centerButtonImageName:kKYICircleMenuCenterButton
                                             centerButtonBackgroundImageName:kKYICircleMenuCenterButtonBackground];
    lMainView.arcTabBar = self;
    UINavigationController *lMainNavController = [[UINavigationController alloc] initWithRootViewController:lMainView];
    
    //image browser controller
    TFImageBrowseViewController *lImageBrowser = [[TFImageBrowseViewController alloc] initWithNibName:@"TFImageBrowseViewController" bundle:nil];
    lImageBrowser.arcTabBar = self;
    
    //setings view controller
    TFSettingsViewController *lSettings = [[TFSettingsViewController alloc] initWithNibName:@"TFSettingsViewController" bundle:nil];
    lSettings.arcTabBar = self;
    
    //help view controller
    TFHelpViewController *lHelp = [[TFHelpViewController alloc] initWithNibName:@"TFHelpViewController" bundle:nil];
    lHelp.arcTabBar = self;
    
    // Set child views' Frame
    CGRect childViewFrame = self.viewFrame;
    [lMainView.view   setFrame:childViewFrame];
    [lImageBrowser.view   setFrame:childViewFrame];
    [lSettings.view setFrame:childViewFrame];
    [lHelp.view  setFrame:childViewFrame];
    
    // Set child views' background color
    [lMainView.view   setBackgroundColor:[UIColor blackColor]];
//    [lImageBrowser.view   setBackgroundColor:[UIColor redColor]];
    [lSettings.view setBackgroundColor:[UIColor greenColor]];
    [lHelp.view  setBackgroundColor:[UIColor blueColor]];
    
    // Add child views as tab bar items
    self.tabBarItems = @[@{@"image"          : @"KYTabBarItem01.png",
                           @"viewController" : lMainNavController},
                         @{@"image"          : @"KYTabBarItem02.png",
                           @"viewController" : lImageBrowser},
                         @{@"image"          : @"KYTabBarItem03.png",
                           @"viewController" : lSettings},
                         @{@"image"          : @"KYTabBarItem04.png",
                           @"viewController" : lHelp}];

}

@end
