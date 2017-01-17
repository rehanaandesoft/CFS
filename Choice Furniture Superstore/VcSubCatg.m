//
//  VcSubCatg.m
//  Choice Furniture Superstore
//
//  Created by Admin on 20/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import "VcSubCatg.h"
#import "VCSubChildCatg.h"

@interface VcSubCatg (){
    NSDictionary *nsCat;
    UIActivityIndicatorView *activityIndicator ;
    UIView *overlay;
    
}


@end

@implementation VcSubCatg

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    overlay= [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    
    [overlay addSubview:activityIndicator];
    [self.view addSubview: overlay];
    
    [activityIndicator startAnimating];
    
    
  
    //if ([nsCat count] == 0) {
        
        NSError *error;
        NSString *url_string = [NSString stringWithFormat: @"https://www.choicefurnituresuperstore.co.uk/appchilld.php?pcategory=%@",_catId];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        if (data.length > 0 && error == nil)
        {
            
            nsCat = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
           
            
        }
    //}
    
    _lblCatName.text=_catName;
    [self fetchCategories:nsCat];
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
    
    if ([[segue identifier] isEqualToString:@"segueSubChildCatg"])
    {
        // Get reference to the destination view controller
        VCSubChildCatg *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.catId = [NSString stringWithFormat:@"%ld", (long)_btnChildSegue.tag];
        vc.catName =[_btnChildSegue titleForState:UIControlStateNormal];
        vc.parentCatName = _catName;
        
    }

}




-(void)fetchCategories:(NSDictionary*)dicYourResponse{
    @try {
        
        
        //        [spinner startAnimating];
        
        
        int x=0,y=0,cnt=1,totalimg=1;
        float width=self.view.frame.size.width;
        float height = 50; //width - (width*0.3);
        for (NSDictionary *rec in dicYourResponse) {
            
            
                     if(_txtSearch.text.length>0){
                
                NSString *title = [rec objectForKey:@"vCategory"];
                if ([title rangeOfString:_txtSearch.text options:NSCaseInsensitiveSearch].location == NSNotFound)
                    continue;
            }
            
            

            UIButton *btnBrand = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
//            btnBrand.imageView.image = img;
//            [btnBrand setImage:img forState:UIControlStateNormal];
//            btnBrand.imageEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
            [btnBrand setBackgroundColor:[UIColor whiteColor]];
            [btnBrand setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            
            [btnBrand setTag:[[rec objectForKey:@"iCategoryId"] integerValue]];
            [btnBrand setTitle:[rec objectForKey:@"vCategory"] forState:UIControlStateNormal];
            [btnBrand setTitleColor:[UIColor colorWithRed:104/255.0f green:104/255.0f blue:104/255.0f alpha:1.f] forState:UIControlStateNormal];
            [btnBrand.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueBold" size:20]];
            [_scrBrand addSubview:btnBrand];
            btnBrand.contentEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
            [btnBrand addTarget:self action:@selector(btnCatgClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    _btnChildSegue.tag= sender.tag;
    [_btnChildSegue setTitle:[sender titleForState:UIControlStateDisabled] forState:UIControlStateNormal];
    //NSLog(@"%@",[sender titleForState:UIControlStateDisabled]);
    [self performSegueWithIdentifier:@"segueSubChildCatg" sender:self];
}



- (IBAction)txtChanged:(UITextField *)sender {
    
    @try{
        
        if(sender.text.length==0 ||  sender.text.length>1){
            [[_scrBrand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self fetchCategories:nsCat];
        }
        
        
        
        
    }
    @catch(NSException *exception){
        NSLog(@"%@",exception);
        
    }
}

- (IBAction)btnSearch:(UIButton *)sender {
    
    if(sender.tag==1){
        _txtSearch.hidden=NO;
        sender.tag=2;
        [sender setImage:nil forState:UIControlStateNormal];
        [sender setTitle:@"X" forState:UIControlStateNormal ];
        
        [_txtSearch becomeFirstResponder];
    }
    else
    {
        _txtSearch.hidden=YES;
        sender.tag=1;
        [sender setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
        [sender setTitle:nil forState:UIControlStateNormal ];
        _txtSearch.text=@"";
        [[_scrBrand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self fetchCategories:nsCat];
        [_txtSearch resignFirstResponder];
        
        
    }
    
}





@end
