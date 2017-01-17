//
//  VcBrands.m
//  Choice Furniture Superstore
//
//  Created by Admin on 17/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import "VcBrands.h"
#import "VcRangeList.h"

@interface VcBrands ()
{
    NSDictionary *nsBrands;
    UIActivityIndicatorView *activityIndicator ;
    UIView *overlay;
    BOOL loaded;
}
@end

@implementation VcBrands


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //  [self fetchBrands];
    loaded=NO;
    
    overlay= [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
  activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    
    [overlay addSubview:activityIndicator];
    [self.view addSubview: overlay];
    
    [activityIndicator startAnimating];
    
    
    nsBrands = [[NSUserDefaults standardUserDefaults] objectForKey:@"BrandsCookie"];
    if ([nsBrands count] == 0) {
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"https://www.choicefurnituresuperstore.co.uk/appallbrand.php"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        if (data.length > 0 && error == nil)
        {

            nsBrands = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [[NSUserDefaults standardUserDefaults] setObject:nsBrands forKey:@"BrandsCookie"];
            
        }
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    if(loaded==NO){
    [self fetchBrands];
        loaded=YES;
    }

    
}

-(void)fetchBrands{
    @try {
        
            int x=10,y=10,cnt=1,totalimg=1;
                 float width=(self.view.frame.size.width-40)/3;
                 float height = width - (width*0.3);
          for (NSDictionary *rec in nsBrands) {
              if(_txtSearch.text.length>0){
                  
                NSString *title = [rec objectForKey:@"vTitle"];
                  if ([title rangeOfString:_txtSearch.text options:NSCaseInsensitiveSearch].location == NSNotFound)
                     continue;
              }
              UIImage *img =[UIImage imageNamed:@"loading.png"];
                     UIButton *btnBrand = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
              
                     [btnBrand setImage:img forState:UIControlStateNormal];
                     [btnBrand.imageView setContentMode:UIViewContentModeScaleAspectFit];
                     btnBrand.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 10);
                     [btnBrand setBackgroundColor:[UIColor whiteColor]];
                     [cfs setBorder:btnBrand];
              [btnBrand setTag:[[rec objectForKey:@"iBrandId"] intValue]];
              [btnBrand setTitle:[rec objectForKey:@"vTitle"] forState:UIControlStateDisabled];
                      [btnBrand addTarget:self action:@selector(btnBrandClick:) forControlEvents:UIControlEventTouchUpInside];
              
                     [_scrBrand addSubview:btnBrand];
                    NSArray *param= [[NSArray alloc]initWithObjects:[rec objectForKey:@"4"],btnBrand, nil];
                   
              [self performSelectorInBackground:@selector(LoadImage:) withObject:param];
              
                     cnt++;
                     x+=width+10;
                     if(cnt>3){
                         x=10;
                         y+=height+10;
                         cnt=1;
                         totalimg++;
                     }
                     
              
                    // if(totalimg==2) break;
                     
                 }
                 [_scrBrand setScrollEnabled:YES];
                 
                 [_scrBrand setContentSize:CGSizeMake(0, totalimg*(height+10))];
                 [activityIndicator stopAnimating];
                 [overlay setHidden:YES];
        
        
    
        
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
        
}

- (IBAction)txtChanged:(UITextField *)sender {

    @try{
        
        if(sender.text.length==0 ||  sender.text.length>1){
            [[_scrBrand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self fetchBrands];
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
        [self fetchBrands];
        [_txtSearch resignFirstResponder];

        
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
    
    if ([[segue identifier] isEqualToString:@"rangeListAction"])
    {
        // Get reference to the destination view controller
        VcRangeList *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.brandId = [NSString stringWithFormat:@"%ld", (long)_btnRange.tag];
        vc.brandName =[_btnRange titleForState:UIControlStateDisabled];
    }
    
}


- (IBAction)btnBackClick:(UIButton *)sender {
    
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (IBAction)btnBrandClick:(UIButton *)sender {
    
    _btnRange.tag = sender.tag;
    [_btnRange setTitle:[sender titleForState:UIControlStateDisabled] forState:UIControlStateDisabled];
    [self performSegueWithIdentifier:@"rangeListAction" sender:self];
}



-(void)LoadImage:(NSArray *) sender{
    [cfs LoadImage:sender];
}



@end



