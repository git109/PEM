//
//  PEMLoginViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMLoginViewController.h"
#import "PEMTextFieldValidation.h"
#import "PEMDatabaseQueries.h"

@implementation PEMLoginViewController

@synthesize email = _email;
@synthesize password = _password;
@synthesize statusMessage = _statusMessage;


- (IBAction)login:(id)sender {
    
    PEMDatabaseQueries *dbQueries = [[PEMDatabaseQueries alloc] init];
    
    // validate email
    PEMTextFieldValidation *textFieldValidation = [[PEMTextFieldValidation alloc] init];
    if (![textFieldValidation isValidEmail: _email.text]) {
        
        _statusMessage.text = @"Invalid email";
        
    }
    
    // check if email/user exists
    else if ([[dbQueries fetchSelectedFromDatabase:@"Profiles" :@"email" :_email.text] count] == 0) {
        
        _statusMessage.text = @"User doesn't exist";
    
    }
        
    // check if password matches
    else if ([[dbQueries fetchSelectedFromDatabase:@"Profiles" :@"password" :_password.text] count] == 0) {
        
        _statusMessage.text = @"Invalid password";
        
        } else {
            
            // switch to the profile view
            [self performSegueWithIdentifier:@"loginSegue" sender:sender];
        }

}
        

// give up first responder status - hide keyboard when done typing
// gets executed on every app's loop
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == _email) {
        
        [theTextField resignFirstResponder];
    }
    
    else if (theTextField == _password) {
        
        [theTextField resignFirstResponder];
    }
    
    return YES;
}


/*

// do something before segue is executed
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"loginSegue"]) {
        
        // Get destination view
        PEMProfileViewController *profileViewController = [segue destinationViewController];
        
        // Get button tag number (or do whatever you need to do here, based on your object
        NSInteger tagIndex = [(UIButton *)sender tag];
        
        // Pass the information to your destination view
        [vc setSelectedButton:tagIndex];
    }
}
 
 */


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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
