//
//  PEMProfileViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMProfileViewController.h"

@implementation PEMProfileViewController

@synthesize dbQueries;
@synthesize textFieldValidation;
@synthesize textFieldSlider;
@synthesize dataCenter;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize email = _email;
@synthesize password = _password;
@synthesize re_password = _re_password;
@synthesize statusMessage = _statusMessage;
@synthesize user;
@synthesize bodyWeightPicker = _bodyWeightPicker;
@synthesize bodyWeightPickerArray;
@synthesize choice;



// Sliding UITextFields around to avoid the keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textFieldSlider slideUp:self.view:textField];
}


// Animate back again
// call updateProfileData method to save data to database on each exit from textfield
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [textFieldSlider slideDown:self.view:textField];
    
    [self updateProfileData: textField];

}


// load profile data from database
- (void)loadProfileData {
    
    user = dataCenter.user;
    
    [_firstName setText: [user valueForKey:@"firstName"]];
    [_lastName setText:[user valueForKey:@"lastName"]];
    [_email setText: [user valueForKey:@"email"]];
    [_password setText: [user valueForKey:@"password"]];
    [_re_password setText: [user valueForKey:@"password"]];
    
    if (![[user valueForKey:@"bodyWeight"] isEqualToString:@""]) {
    
        [bodyWeightButton setTitle:[user valueForKey:@"bodyWeight"] forState:UIControlStateNormal];
    }
    
}



// create actionsheet
- (IBAction)showOptions:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Upload Profile", @"Log Out", nil];
    actionSheet.destructiveButtonIndex = 1;
    [actionSheet showInView:self.parentViewController.view];
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



// slide picker view
- (IBAction)selectBodyWeight:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 400);
    _bodyWeightPicker.transform = transfrom;
    _bodyWeightPicker.alpha = _bodyWeightPicker.alpha * (-1) + 1;
    [UIView commitAnimations];    
    
    NSInteger row = [_bodyWeightPicker selectedRowInComponent:0];
    choice = [bodyWeightPickerArray objectAtIndex:row];
    
    [bodyWeightButton setTitle:choice forState:UIControlStateNormal];
    [user setValue:choice forKey:@"bodyWeight"];
    
    // save profile changes to dataCenter for sharing
    dataCenter.user = user;
    
    // save to database
    [dbQueries saveChangesToPersistentStore];

}




// weight picker view helper method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;
}

// weight picker view helper method
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return [bodyWeightPickerArray count];
}

// weight picker view helper method
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return [bodyWeightPickerArray objectAtIndex:row];
}


// update managed object and save to database
- (void)updateProfileData: (UITextField *)theTextField {

    if (theTextField == _firstName) {
        
        [user setValue:_firstName.text forKey:@"firstName"];        
    }
    
    else if (theTextField == _lastName) {
        
        [user setValue:_lastName.text forKey:@"lastName"];
    }
    
    else if (theTextField == _email) {
        
        [user setValue:_email.text forKey:@"email"];
    }
    
    else if (theTextField == _password) {
        
        if([textFieldValidation doPasswordsMatch:_password :_re_password]) {
            
            [user setValue:_password.text forKey:@"password"];
            _statusMessage.text = @"";
            
        }
        
        else {
            
            _statusMessage.text = @"Passwords don't match";
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
    
    else if (theTextField == _re_password) {
        
        if([textFieldValidation doPasswordsMatch:_password :_re_password]) {
            
            [user setValue:_password.text forKey:@"password"];
            _statusMessage.text = @"";
            
        }
        
        else {
            
            _statusMessage.text = @"Passwords don't match";
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
    

    // save to database
    [dbQueries saveChangesToPersistentStore];
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
    
    // scroll view size
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 700)];
    
    
    // initialize the picker view array with weight
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for( int i = 84; i <= 364; ++i )
    {
        NSString *weight = [NSString stringWithFormat:@"%d",i];
        NSString *zero = @",0";
        NSString *pounds = @"lb";
        NSString *totalWeight = [NSString stringWithFormat:@"%@%@ %@",weight,zero,pounds];
        
        [values addObject:[NSString stringWithString:totalWeight]];
    }
    self.bodyWeightPickerArray = values;
    
    
    // set bodyWeightPicker invisible
    _bodyWeightPicker.alpha = 0;
    
    
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
