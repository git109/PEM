//
//  PEMCreateProfileViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMCreateProfileViewController.h"

@implementation PEMCreateProfileViewController

@synthesize email = _email;
@synthesize password = _password;
@synthesize re_password = _re_password;
@synthesize statusMessage = _statusMessage;


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


// Create user profile
- (void) createProfile:(id)sender {
    
    PEMTextFieldValidation *textFieldValidation = [[PEMTextFieldValidation alloc] init];
    PEMDatabaseQueries *dbQueries = [[PEMDatabaseQueries alloc] init];
    
    // validate email
    if (![textFieldValidation isValidEmail: _email.text]) {
        
        _statusMessage.text = @"Invalid email";
    
    }
    
    // check if user already exists
    else if ([[dbQueries fetchSelectedFromDatabase:@"Profiles" :@"email == %@" :_email.text] count] != 0) {
        
        _statusMessage.text = @"User already exists";
    }
    
    // check if passwords match
    else if (![textFieldValidation doPasswordsMatch:_password :_re_password]) {
        
        _statusMessage.text = @"Passwords don't match";
        
    }

    
    else {
        
        // insert profile to database
        [self insertProfileToDatabase:@"" :@"" :_email.text :_password.text];
        
        // clear all fields
        _email.text = @"";
        _password.text = @"";
        _re_password.text = @"";
        
        // profile created alert
        UIAlertView *profileCreatedAlert =
        [[UIAlertView alloc] initWithTitle:@"Profile Successfully Created!" 
                                   message:@"Please log in."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [profileCreatedAlert show];
        
        // switch back to the login view to log in
        [self performSegueWithIdentifier:@"userCreatedSegue" sender:sender];

    }
}


// insert profile to database
- (void) insertProfileToDatabase:
(NSString *)theFirstName:
(NSString *)theLastName:
(NSString *)theEmail:
(NSString *)thePassword {
    
    PEMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = 
    [appDelegate managedObjectContext];
    
    NSManagedObject *newProfile;
    newProfile = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Profiles"
                  inManagedObjectContext:context];
    [newProfile setValue:theFirstName forKey:@"firstName"];
    [newProfile setValue:theLastName forKey:@"lastName"];
    [newProfile setValue:theEmail forKey:@"email"];
    [newProfile setValue:thePassword forKey:@"password"];
    
    
    NSError *error;
    [context save:&error];
    
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
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setEmail:nil];
    [self setPassword:nil];
    [self setRe_password:nil];
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
