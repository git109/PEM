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

@interface PEMTrackingViewController : UIViewController <CLLocationManagerDelegate> {
    
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
    
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startingPoint;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic) BOOL trackingGPS;
@property (nonatomic, retain) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *horizontalAccuracyLabel;
@property (nonatomic, retain) IBOutlet UILabel *altitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *verticalAccuracyLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceTraveledLabel;
@property (nonatomic, retain) IBOutlet UILabel *speedLabel;
@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic) int tick;
@property (nonatomic, retain) IBOutlet UILabel *calories;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (IBAction)startTracking:(id)sender;
- (IBAction)stopTracking:(id)sender;
- (IBAction)resetTracking:(id)sender;

- (void)startTimer;
- (void)stopTimer;
- (void)resetTimer;





@end
