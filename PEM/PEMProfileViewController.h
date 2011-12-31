//
//  PEMProfileViewController.h
//  PEM
//
//  Created by Vladimir Hartmann on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface PEMProfileViewController : UIViewController <UIActionSheetDelegate> {

    UITextField *firstName;
    UITextField *lastName;
    UITextField *email;
    UITextField *password;
    UITextField *re_password;
    NSManagedObject *user;
    IBOutlet UIScrollView *scrollView;
}
@property (retain, nonatomic) NSManagedObject *user;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *re_password;


- (void)loadProfileData;

- (IBAction)showOptions:(id)sender;

- (void)logout;

@end
