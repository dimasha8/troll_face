//
//  TFAbstractViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFAbstractViewController.h"

@interface TFAbstractViewController ()

@end

@implementation TFAbstractViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
