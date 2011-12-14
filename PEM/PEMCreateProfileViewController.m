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

@synthesize email = _email;
@synthesize password = _password;
@synthesize re_password = _re_password;
@synthesize statusMessage = _statusMessage;

// for Sliding UITextFields around to avoid the keyboard
CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;


// Sliding UITextFields around to avoid the keyboard
// Method implemented by following http://cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Get the rects of the text field being edited
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    // Calculate the fraction between the top and bottom of the middle section for the text field's midline
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    // Clamp this fraction
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    // Convert it into an amount to scroll by multiplying by the keyboard height for the current screen orientation
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    // Apply the animation
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


// Animate back again (helper method to textFieldDidBeginEditing:textField method)
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


// Create user profile
- (void) createProfile:(id)sender {
    
    // validate email
    if (![self isValidEmail: _email.text]) {
        
        _statusMessage.text = @"Invalid email";
    
    }
    
    // check if passwords match
    else if (![self doPasswordsMatch:_password :_re_password]) {
        
        _statusMessage.text = @"Passwords don't match";
        
    }

    
    else {
        
        // write to database
        [self insertProfileToDatabase];
        
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


// empty textfiled check
- (BOOL)isFieldEmpty: (UITextField *)textField {
    
    if ([textField.text length] == 0) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}


// email validation
- (BOOL)isValidEmail: (NSString *)emailEntry {
    
    NSString *string = emailEntry;
    NSString *expression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (match) {
        return YES;
    } else {
        return NO;
    }
    
}


// check if both passwords match
- (BOOL)doPasswordsMatch: (UITextField *)password1: (UITextField *)password2 {
    
    if (([self isFieldEmpty:password1]) || ([self isFieldEmpty:password2])) {
        
        return NO;
        
    }

    else if ([password1.text isEqualToString:password2.text]) {
        
        return YES;
        
    }
        
    else {
    
        return NO;
    }
}


// insert profile data to database
- (void) insertProfileToDatabase {
    
    PEMAppDelegate *appDelegate = 
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = 
    [appDelegate managedObjectContext];
    NSManagedObject *newProfile;
    newProfile = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Profiles"
                  inManagedObjectContext:context];
    [newProfile setValue:@"" forKey:@"firstName"];
    [newProfile setValue:@"" forKey:@"lastName"];
    [newProfile setValue:_email.text forKey:@"email"];
    [newProfile setValue:_password.text forKey:@"password"];
    
    // clear all fields
    _email.text = @"";
    _password.text = @"";
    _re_password.text = @"";
    
    NSError *error;
    [context save:&error];

}




/*
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
 
 */


// give up first responder status - hide keyboard when done typing
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _email) {
        
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
