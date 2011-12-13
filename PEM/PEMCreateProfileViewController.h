//
//  PEMCreateProfileViewController.h
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface PEMCreateProfileViewController : UIViewController <UITextFieldDelegate> {

    UITextField *firstName;
    UITextField *lastName;
    UITextField *userName;
    UITextField *password;

}
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;


- (IBAction)createProfile:(id)sender;
- (IBAction)findProfile:(id)sender;

@end
