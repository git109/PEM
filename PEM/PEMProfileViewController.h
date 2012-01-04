//
//  PEMProfileViewController.h
//  PEM
//
//  Created by Vladimir Hartmann on 14/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMDatabaseQueries.h"
#import "PEMDataCenter.h"
#import "PEMTextFieldSlider.h"
#import "PEMTextFieldValidation.h"
#import "PEMAppDelegate.h"


@interface PEMProfileViewController : UIViewController <UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {

    UITextField *firstName;
    UITextField *lastName;
    UITextField *email;
    UITextField *password;
    UITextField *re_password;
    UILabel *statusMessage;
    NSManagedObject *user;
    IBOutlet UIScrollView *scrollView;
    UIPickerView *bodyWeightPicker;
    NSMutableArray *bodyWeightPickerArray;
    IBOutlet UIButton *bodyWeightButton;
    NSString *choice;

}
@property (retain, nonatomic) NSManagedObject *user;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *re_password;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (weak, nonatomic) IBOutlet UIPickerView *bodyWeightPicker;
@property (retain, nonatomic) NSMutableArray *bodyWeightPickerArray;
@property (retain, nonatomic) NSString *choice;




- (void)loadProfileData;
- (void)updateProfileData: (UITextField *)theTextField;
- (IBAction)showOptions:(id)sender;
- (void)logout;
- (IBAction)selectBodyWeight:(id)sender;






@end
