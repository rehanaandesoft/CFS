//
//  VcMainController.h
//  Choice Furniture Superstore
//
//  Created by Admin on 22/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "cfs.h"
#import <CoreLocation/CoreLocation.h>


@interface VcMainController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic,retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIView *uvBrand;
@property (weak, nonatomic) IBOutlet UIView *uvCatg;
@property (weak, nonatomic) IBOutlet UIButton *btnBrand;
@property (weak, nonatomic) IBOutlet UIButton *btnCatg;

@end
