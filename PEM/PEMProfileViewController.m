//
//  PEMProfileViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMProfileViewController.h"
#import "PEMDatabaseQueries.h"
#import "PEMDataCenter.h"
#import "PEMTextFieldSlider.h"

@implementation PEMProfileViewController

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize email = _email;
@synthesize password = _password;
@synthesize re_password = _re_password;

@synthesize user;



// Sliding UITextFields around to avoid the keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    PEMTextFieldSlider *textFieldSlider = [[PEMTextFieldSlider alloc] init];
    [textFieldSlider slideUp:self.view:textField];
}


// Animate back again (helper method to textFieldDidBeginEditing:textField method)
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    PEMTextFieldSlider *textFieldSlider = [[PEMTextFieldSlider alloc] init];
    [textFieldSlider slideDown:self.view:textField];
}



- (void)loadProfileData {
    
    PEMDataCenter *dataCenter = [PEMDataCenter shareDataCenter];
    user = dataCenter.user;
    
    [_firstName setText: [user valueForKey:@"firstName"]];
    [_lastName setText:[user valueForKey:@"lastName"]];
    [_email setText: [user valueForKey:@"email"]];
    [_password setText: [user valueForKey:@"password"]];
    
}


// create actionsheet
- (IBAction)showOptions:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Upload Profile", @"Log Out", nil];
    actionSheet.destructiveButtonIndex = 1;
    [actionSheet showInView:self.view];
}


// handle actionsheet buttons
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"Transfer data online");
            break;
            
        case 1:
            // switch to the login view
            [self logout];
            break;
        
        default:
            break;
    }
    
}


// change to login view
- (void)logout {
    
    [self performSegueWithIdentifier:@"goToLoginView" sender:self];
    
}


// give up first responder status - hide keyboard when done typing
// gets executed on every app's loop
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == _firstName) {
        
        [theTextField resignFirstResponder];
    }
    
    else if (theTextField == _lastName) {
        
        [theTextField resignFirstResponder];
    }
    
    else if (theTextField == _email) {
        
        [theTextField resignFirstResponder];
    }
    
    else if (theTextField == _password) {
        
        [theTextField resignFirstResponder];
    }
    
    else if (theTextField == _re_password) {
        
        [theTextField resignFirstResponder];
    }

    
    return YES;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 800)];
    
    [self loadProfileData];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setEmail:nil];
    [self setPassword:nil];
    [self setRe_password:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
