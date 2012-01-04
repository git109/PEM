//
//  PEMLoginViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMLoginViewController.h"

@implementation PEMLoginViewController

@synthesize dbQueries;
@synthesize textFieldSlider;
@synthesize textFieldValidation;
@synthesize dataCenter;
@synthesize email = _email;
@synthesize password = _password;
@synthesize statusMessage = _statusMessage;



// Sliding UITextFields around to avoid the keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textFieldSlider slideUp:self.view:textField];
}


// Animate back again (helper method to textFieldDidBeginEditing:textField method)
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textFieldSlider slideDown:self.view:textField];
}


- (IBAction)login:(id)sender {
        
    // validate email
    if (![textFieldValidation isValidEmail: _email.text]) {
        
        _statusMessage.text = @"Invalid email";
        
    }
    
    NSArray *users = [dbQueries fetchSelectedFromDatabase:@"Profiles" :@"email == %@" :_email.text];
    
    
    // check if email/user exists
    if ([users count] == 0) {
        
        _statusMessage.text = @"User doesn't exist";
    
    }
    
    // check if passwords match
    else if (![[[users objectAtIndex:0] valueForKey:@"password"] isEqualToString: _password.text]) {
        
        _statusMessage.text = @"Invalid password";
        
        } else {
            
            // save this particular profile to data center for sharing
            dataCenter.user = [users objectAtIndex:0];

            // switch to the profile view
            [self performSegueWithIdentifier:@"goToProfileView" sender:sender];

        }

}
        

// give up first responder status - hide keyboard when done typing
// gets executed on every app's loop
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];

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
- (void)viewDidLoad {
    
    dbQueries = [[PEMDatabaseQueries alloc] init];
    textFieldSlider = [[PEMTextFieldSlider alloc] init];
    textFieldValidation = [[PEMTextFieldValidation alloc] init];
    dataCenter = [PEMDataCenter shareDataCenter];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setEmail:nil];
    [self setPassword:nil];
    [self setStatusMessage:nil];
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
