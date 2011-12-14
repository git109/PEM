//
//  PEMCreateProfileViewController.h
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface PEMCreateProfileViewController : UIViewController <UITextFieldDelegate> {


    UITextField *email;
    UITextField *password;
    UITextField *re_password;
    UILabel *statusMessage;

}

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *re_password;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;


- (IBAction)createProfile:(id)sender;
- (BOOL)isFieldEmpty: (UITextField *)textField;
- (BOOL)isValidEmail: (NSString *)emailEntry;
- (BOOL)doPasswordsMatch: (UITextField *)password1: (UITextField *)password2;
- (void) insertProfileToDatabase;


@end
