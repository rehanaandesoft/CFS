//
//  VcCategory.m
//  Choice Furniture Superstore
//
//  Created by Admin on 17/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import "VcCategory.h"
#import "VcSubCatg.h"

@interface VcCategory ()
{
    NSDictionary *nsCat;
    UIActivityIndicatorView *activityIndicator ;
    UIView *overlay;
    

}
@end

@implementation VcCategory

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self fetchCategories];
    overlay= [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    
    [overlay addSubview:activityIndicator];
    [self.view addSubview: overlay];
    
    [activityIndicator startAnimating];
    
    
    nsCat = [[NSUserDefaults standardUserDefaults] objectForKey:@"CategoryCookie"];
    if ([nsCat count] == 0) {
        
        NSError *error;
        NSString *url_string = [NSString stringWithFormat: @"https://www.choicefurnituresuperstore.co.uk/appcat.php"];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        if (data.length > 0 && error == nil)
        {
            
            nsCat = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [[NSUserDefaults standardUserDefaults] setObject:nsCat forKey:@"CategoryCookie"];
            
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"segueSubCatg"])
    {
        // Get reference to the destination view controller
        VcSubCatg *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.catId = [NSString stringWithFormat:@"%ld", (long)_btnCatSegue.tag];
        vc.catName =[_btnCatSegue titleForState:UIControlStateNormal];
        
    }
    
}


-(void)viewDidAppear:(BOOL)animated{
    [self fetchCategories:nsCat];
}

-(void)fetchCategories:(NSDictionary*)dicYourResponse{
    @try {
        
 
//        [spinner startAnimating];
    
                 
                 int x=0,y=0,cnt=1,totalimg=1;
                 float width=self.view.frame.size.width;
                 float height = 60; //width - (width*0.3);
                 for (NSDictionary *rec in dicYourResponse) {
                     
                     
                     NSString *imgname= [rec objectForKey:@"vCategory"];
                     
                     UILabel *lblCat =[[UILabel alloc]initWithFrame:CGRectMake(x+80, y, width-80, height)];
                     [lblCat setTextColor:[UIColor colorWithRed:104/255.0f green:104/255.0f blue:104/255.0f alpha:1.f]];
                     [lblCat setText:imgname];
                     [lblCat setFont:[UIFont fontWithName:@"HelveticaNeueBold" size:20]];
                     
                     
                     
                     
                     imgname = [imgname lowercaseString];
                     
                     imgname =[imgname stringByReplacingOccurrencesOfString:@" " withString:@"_"];
                     imgname = [NSString stringWithFormat:@"%@_icon.png",imgname];
                
                     
                     UIImage *img = [UIImage imageNamed:imgname];
                     UIButton *btnBrand = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
                     btnBrand.imageView.image = img;
                     [btnBrand setImage:img forState:UIControlStateNormal];
                     btnBrand.imageEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
                     [btnBrand setBackgroundColor:[UIColor whiteColor]];
                      [btnBrand setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                     [btnBrand addTarget:self action:@selector(btnCatgClick:) forControlEvents:UIControlEventTouchUpInside];
                     [btnBrand setTitle:[rec objectForKey:@"vCategory"] forState:UIControlStateDisabled];
                     [btnBrand setTag:[[rec objectForKey:@"iCategoryId"] integerValue]];
                     [_scrBrand addSubview:btnBrand];
                     [_scrBrand addSubview:lblCat];
                     
                     cnt++;
                                          y+=height+1;
                     totalimg++;

                     
                 }
                 [_scrBrand setScrollEnabled:YES];
                 
                 [_scrBrand setContentSize:CGSizeMake(0, totalimg*55)];
                 [_scrBrand setBackgroundColor:[UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1.f]];
                 [activityIndicator stopAnimating];
                 [overlay removeFromSuperview];
        
        
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
    
}

- (IBAction)btnBackClick:(UIButton *)sender {
    
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btnCatgClick:(UIButton *)sender {
    
    _btnCatSegue.tag= sender.tag;
    [_btnCatSegue setTitle:[sender titleForState:UIControlStateDisabled] forState:UIControlStateNormal];
    NSLog(@"%@",[sender titleForState:UIControlStateDisabled]);
    [self performSegueWithIdentifier:@"segueSubCatg" sender:self];
}

@end
