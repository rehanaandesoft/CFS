//
//  VcRangeList.h
//  Choice Furniture Superstore
//
//  Created by Admin on 18/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VcRangeList : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIScrollView *scrBrand;
@property (weak, nonatomic) IBOutlet UILabel *lblHead;

@property (nonatomic, strong) NSString *brandId;
@property (nonatomic, strong) NSString *brandName;
@property (weak, nonatomic) IBOutlet UIWebView *uvWeb;

- (IBAction)btnBackClick:(UIButton *)sender;

-(void)fetchRanges;
@end
