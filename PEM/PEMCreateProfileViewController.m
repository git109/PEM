//
//  PEMCreateProfileViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMCreateProfileViewController.h"
#import "PEMAppDelegate.h"

@implementation PEMCreateProfileViewController

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize userName = _userName;
@synthesize password = _password;


- (void) createProfile:(id)sender
{
    PEMAppDelegate *appDelegate = 
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = 
    [appDelegate managedObjectContext];
    NSManagedObject *newProfile;
    newProfile = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Profiles"
                  inManagedObjectContext:context];
    [newProfile setValue:_firstName.text forKey:@"firstName"];
    [newProfile setValue:_lastName.text forKey:@"lastName"];
    [newProfile setValue:_userName.text forKey:@"userName"];
    [newProfile setValue:_password.text forKey:@"password"];
    
    // clear all fields
    _firstName.text = @"";
    _lastName.text = @"";
    _userName.text = @"";
    _password.text = @"";
    NSError *error;
    [context save:&error];
}


- (IBAction)findProfile:(id)sender {
    
    PEMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = 
    [NSEntityDescription entityForName:@"Profiles" 
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *profile = nil;
    
    if ([objects count] != 0) {
        
        profile = [objects objectAtIndex:0];
        _firstName.text = [profile valueForKey:@"firstName"];
        _lastName.text = [profile valueForKey:@"lastName"];
        _userName.text = [profile valueForKey:@"userName"];
        _password.text = [profile valueForKey:@"password"];

    }

    
}


// give up first responder status - hide keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.password) {
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
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setFirstName:nil];
    [self setLastName:nil];
    [self setUserName:nil];
    [self setPassword:nil];
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
