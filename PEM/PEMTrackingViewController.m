//
//  PEMFirstViewController.m
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMTrackingViewController.h"

@implementation PEMTrackingViewController

@synthesize managedObjectContext = _managedObjectContext;

@synthesize locationManager;
@synthesize startingPoint;
@synthesize mapView;
@synthesize trackingGPS;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize horizontalAccuracyLabel;
@synthesize altitudeLabel;
@synthesize verticalAccuracyLabel;
@synthesize distanceTraveledLabel;
@synthesize speedLabel;
@synthesize time;
@synthesize timer;
@synthesize tick;
@synthesize calories;


-(id) init {
    
	if (self = [super init]) {
        
		trackingGPS = TRUE;
	}
	return self;
}


// start gps tracking and timer
- (IBAction)startTracking:(id)sender {
    
    if (trackingGPS) {
        
        return;
    }
    else {
        
        [locationManager startUpdatingLocation];
        mapView.showsUserLocation = YES;
        [self startTimer];
        trackingGPS = TRUE;
    }
}


// stop gps tracking and timer
- (IBAction)stopTracking:(id)sender {
	[locationManager stopUpdatingLocation];
    [self stopTimer];
    trackingGPS = FALSE;
}


// reset gps tracking and timer
- (void)resetTracking:(id)sender {
	[locationManager stopUpdatingLocation];
	latitudeLabel.text = @"0.00";
	longitudeLabel.text = @"0.00";
	horizontalAccuracyLabel.text = @"0.00";
	altitudeLabel.text = @"0.00";
	verticalAccuracyLabel.text = @"0.00";
	distanceTraveledLabel.text = @"0.00";
	speedLabel.text = @"0.00";
    
    [self resetTimer];
}


// timer methods
- (void)startTimer {
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES]; 
}

- (void)stopTimer {
    
    [timer invalidate];
}

- (void)resetTimer {
    
    int hours, minutes, seconds;
    
    tick = 0;
    hours = 0;
    minutes = 0;
    seconds = 0;
    
    time.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

- (void)updateTimer {

    int hours, minutes, seconds;
    
    tick++;
    hours = tick / 3600;
    minutes = (tick % 3600) / 60;
    seconds = (tick %3600) % 60;
    time.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [self resetTracking:self];
	self.locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
    
    self.locationManager = nil;
	self.latitudeLabel = nil;
	self.longitudeLabel = nil;
	self.horizontalAccuracyLabel = nil;
	self.altitudeLabel = nil;
	self.verticalAccuracyLabel = nil;
	self.distanceTraveledLabel = nil;
	self.speedLabel = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	
	
	
	if (startingPoint == nil)
		self.startingPoint = newLocation;
	
	
	
	NSString *latitudeString = [[NSString alloc] initWithFormat:@"%g\u00B0",
								newLocation.coordinate.latitude];
	latitudeLabel.text = latitudeString;
	
	
	NSString *longitudeString = [[NSString alloc] initWithFormat:@"%g\u00B0",
								 newLocation.coordinate.longitude];
	longitudeLabel.text = longitudeString;
	
	
	NSString *horizontalAccuracyString = [[NSString alloc] initWithFormat:@"%gm",
										  newLocation.horizontalAccuracy];
	horizontalAccuracyLabel.text = horizontalAccuracyString;
	
	
	NSString *altitudeString = [[NSString alloc] initWithFormat:@"%gm",
								newLocation.altitude];
	altitudeLabel.text = altitudeString;
	
	
	NSString *verticalAccuracyString = [[NSString alloc] initWithFormat:@"%gm",
										newLocation.verticalAccuracy];
	verticalAccuracyLabel.text = verticalAccuracyString;
	
	CLLocationDistance distance = [newLocation distanceFromLocation:startingPoint];
	
	distanceString = [[NSString alloc] initWithFormat:@"%gm", distance];
	distanceTraveledLabel.text = distanceString;
	
	NSString *speedString = [[NSString alloc] initWithFormat:@"%gm",
							 newLocation.speed];
	speedLabel.text = speedString;
	
	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error {
	
	NSString *errorType = (error.code == kCLErrorDenied) ?
	@"Acces Denied" : @"Unknown Error";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting location"
													message: errorType
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
