//
//  PEMFirstViewController.h
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "PEMDataCenter.h"

@interface PEMTrackingViewController : UIViewController <CLLocationManagerDelegate, UIAlertViewDelegate> {
    
    PEMDataCenter *dataCenter;
    NSManagedObject *user;
    CLLocationManager *locationManager;
	CLLocation *startingPoint;	
	MKMapView *mapView;	
    BOOL trackingGPS;
	UILabel *latitudeLabel;
	UILabel *longitudeLabel;
	UILabel *horizontalAccuracyLabel;
	UILabel *altitudeLabel;
	UILabel *verticalAccuracyLabel;
	UILabel *distanceTraveledLabel;
	NSString *distanceString;
	UILabel *speedLabel;
    IBOutlet UILabel *time;
    NSTimer *timer;
    int tick;
    UILabel *calories;
    id startTrackingButtonSender;
    
}

@property (strong, nonatomic) PEMDataCenter *dataCenter;
@property (strong, nonatomic) NSManagedObject *user;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startingPoint;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) BOOL trackingGPS;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *horizontalAccuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *verticalAccuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceTraveledLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) int tick;
@property (weak, nonatomic) IBOutlet UILabel *calories;
@property (strong) id startTrackingButtonSender;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (IBAction)startTracking:(id)sender;
- (IBAction)stopTracking:(id)sender;
- (IBAction)resetTracking:(id)sender;

- (void)startTimer;
- (void)stopTimer;
- (void)resetTimer;
- (BOOL)isReadyToCalculateCalorieExpenditure;
- (void)notifyAboutMissingInfo;




@end
