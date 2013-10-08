//
//  CreateNewViewController.m
//  TrollFace
//
//  Created by dmytro.nosulich on 10/8/13.
//  Copyright (c) 2013 dmytro.nosulich. All rights reserved.
//

typedef enum {
    Camera = 0,
    Library,
    Social,
    Pattern,
    Google,
}LoadButtonIndex;

#import "TFCreateNewViewController.h"

@interface TFCreateNewViewController ()
- (IBAction)loadImagePressed:(UIButton *)pSender;
@end

@implementation TFCreateNewViewController

#pragma mark - Life cicle
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

#pragma mark - IB actions
- (void)loadImagePressed:(UIButton *)pSender {
    PhotoPickerViewController *lPhotoController = [PhotoPickerViewController new];
    [lPhotoController setDelegate:self];
    [self presentViewController:lPhotoController animated:YES completion:nil];
    
    switch (pSender.tag) {
        case Camera:
            
            break;
            
        case Library:
            
            break;
            
        case Social:
            
            break;
            
        case Pattern:
            
            break;
            
        case Google:
            
            break;
            
            
        default:
            break;
    }
}

#pragma mark - PhotoPickerViewControllerDelegate
/**
 Called when the user had finished picking and had selected one asset.
 */
- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    DLog(@"infp: %@", info);
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 Called when the user had finished picking and had selected multiple assets, which are returned in an array.
 */
- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info {
    
}
/**
 Called when the user canceled the picking.
 */
- (void)imagePickerControllerDidCancel:(PhotoPickerViewController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
