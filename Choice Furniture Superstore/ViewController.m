//
//  ViewController.m
//  Choice Furniture Superstore
//
//  Created by Admin on 17/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [cfs setBorder:(UIControl*)_uvBrand];
    [cfs setBorder:(UIControl*)_uvCatg];
    
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        _btnBrand.hidden=_btnCatg.hidden=YES;
        
    }
    else{
        
        
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
        CLLocation *location = [_locationManager location];
        CLLocationCoordinate2D coordinate = [location coordinate];
        NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSError *error;
        NSString *url_string = [NSString stringWithFormat: @"https://www.choicefurnituresuperstore.co.uk/appuserlocation.php?deviceid=%@&latitude=%f&longitude=%f",uniqueIdentifier,coordinate.latitude,coordinate.longitude];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_string] options:NSDataReadingUncached error:&error   ];
        if (error){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not connect to server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _btnBrand.hidden=_btnCatg.hidden=YES;

            
            
        }
        
        
    }

    
    
    
    
}



-(void)viewDidAppear:(BOOL)animated{
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
