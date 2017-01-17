
//
//  VcBrands.h
//  Choice Furniture Superstore
//
//  Created by Admin on 17/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cfs.h"

@interface VcBrands : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIScrollView *scrBrand;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnRange;

- (IBAction)btnBackClick:(UIButton *)sender;

- (IBAction)btnBrandClick:(UIButton *)sender;

-(void)fetchBrands;

- (IBAction)txtChanged:(UITextField*)sender;
- (IBAction)btnSearch:(UIButton *)sender;

@end
