//
//  VcCategory.h
//  Choice Furniture Superstore
//
//  Created by Admin on 17/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cfs.h"

@interface VcCategory : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIScrollView *scrBrand;
@property (weak, nonatomic) IBOutlet UIButton *btnCatSegue;

- (IBAction)btnBackClick:(UIButton *)sender;

-(void)fetchCategories:(NSDictionary*)dicYourResponse;
@end
