//
//  PEMLoginViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMLoginViewController.h"
#import "PEMProfileViewController.h"
#import "PEMAppDelegate.h"

@implementation PEMLoginViewController

@synthesize email = _email;
@synthesize password = _password;
@synthesize statusMessage = _statusMessage;


- (IBAction)login:(id)sender {
    
    // check if email/user exists
    
    PEMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = 
    [NSEntityDescription entityForName:@"Profiles" 
                inManagedObjectContext:context];
    
    NSFetchRequest *emailRequest = [[NSFetchRequest alloc] init];
    [emailRequest setEntity:entityDesc];
    
    NSPredicate *emailPredicate = 
    [NSPredicate predicateWithFormat:@"(email = %@)", _email.text];
    [emailRequest setPredicate:emailPredicate];
    
    NSError *error;
    NSArray *emailObject = [context executeFetchRequest:emailRequest error:&error];
    
    if ([emailObject count] == 0) {
        _statusMessage.text = @"User doesn't exist";
    } else {
        
        // check if password matches
        
        NSFetchRequest *passwordRequest = [[NSFetchRequest alloc] init];
        [passwordRequest setEntity:entityDesc];
        
        NSPredicate *passwordPredicate = 
        [NSPredicate predicateWithFormat:@"(password = %@)", _password.text];
        [passwordRequest setPredicate:passwordPredicate];
        
        NSError *error;
        NSArray *passwordObject = [context executeFetchRequest:passwordRequest error:&error];
        
        if ([passwordObject count] == 0) {
            _statusMessage.text = @"Invalid password";
        } else {
            
            _statusMessage.text = @"Welcome";
            
            // switch to the profile view
            [self performSegueWithIdentifier:@"loginSegue" sender:sender];
        }
        
    }
}


// give up first responder status - hide keyboard when done typing
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
