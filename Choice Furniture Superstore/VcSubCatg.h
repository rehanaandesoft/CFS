//
//  VcSubCatg.h
//  Choice Furniture Superstore
//
//  Created by Admin on 20/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VcSubCatg : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIScrollView *scrBrand;
@property (nonatomic, strong) NSString *catId;
@property (nonatomic, strong) NSString *catName;
@property (weak, nonatomic) IBOutlet UILabel *lblCatName;
@property (weak, nonatomic) IBOutlet UIButton *btnChildSegue;

@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

- (IBAction)txtChanged:(UITextField*)sender;
- (IBAction)btnSearch:(UIButton *)sender;



- (IBAction)btnBackClick:(UIButton *)sender;

-(void)fetchCategories:(NSDictionary*)dicYourResponse;


@end
