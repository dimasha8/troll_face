//
//  SettingsViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

#import "TFSettingsViewController.h"

@interface TFSettingsViewController ()
- (IBAction)buttonPressed:(id)sender;
@end

@implementation TFSettingsViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed:(id)sender {
//    TFAlertView *lAlert = [[TFAlertView alloc] initWithTitle:@"TFAle dfgnbdfgtndfdfhdf df gdgf ndfg ndfgn dfng df rt"
//                                                     message:@"sorng ns dnsdlfindf ls dfgnd fgndgfhndgn dgt ng ndg nd gfnd gfnd nd n hgdfnlbsnb sldnb lsd"
//                                                    delegate:self
//                                                   rootView :self.view
//                                           cancelButtonTitle:@"Cancel"
//                                           otherButtonTitles:@"ooooo",nil];
    
//    TFAlertView *lAlert = [[TFAlertView alloc] initInfoViewWithInfo:@" fj sbvj kdbjv db vjhfdbv jkdfkv sdkljhgdkjfh idsh bludifh bkufdhb kydh fbkifdh ikudf hiluhfdigubhfd bhdufihb kufb df hg dbfkjvhdbfk" atLocation:TFLocationTop rootView:self.view];
    
    TFAlertView *lAlert = [[TFAlertView alloc] initWithMessage:@" gvjsdgf ujsdg vjsd vgdf vdf bdsf bsdf gsdb dfb uisd"
                                                      rootView:self.view];
    
    [lAlert showAnimating:YES];
}

- (void)alertView:(NSInteger)pViewTag didSelectButtonAtIndex:(NSInteger)pButtonIndex {
    DLog(@"button index: %li", (long)pButtonIndex);
}

@end
