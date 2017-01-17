//
//  VcRangeList.m
//  Choice Furniture Superstore
//
//  Created by Admin on 18/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import "VcRangeList.h"
#import "cfs.h"

@interface VcRangeList (){
    NSDictionary *nsRange;
    UIActivityIndicatorView *activityIndicator ;
    UIView *overlay;}

@end

@implementation VcRangeList

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
    
   // _brandId = @"87";
    _brandName =[_brandName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
//    NSLog(@"%@",_brandId);
   
    _uvWeb.delegate=self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnBackClick:(UIButton *)sender {
    
    if(sender.tag==2){
        _uvWeb.hidden=true;
        _lblHead.text=@"Range List";
        sender.tag=0;
        [_uvWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        
        
    }
    else{
    [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"https://www.choicefurnituresuperstore.co.uk/appbrandrangemap.php?iBrandId=%@",_brandId];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    if (data.length > 0 && error == nil)
    {
        
        nsRange = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        [self fetchRanges];
        
    }
    
    
    
}



-(void)fetchRanges{
    @try {
        
        int x=10,y=10,cnt=1,totalimg=1;
        float width=(self.view.frame.size.width-30)/2;
        float height = width - (width*0.2);
        for (NSDictionary *rec in nsRange) {
            
//            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[rec objectForKey:@"6"]]];
//            
//            NSLog(@"%@",[rec objectForKey:@"vTitle"]);
//            UIImage *img = [UIImage imageWithData:imageData];
            
            
            UIButton *btnBrand = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];

            [btnBrand setImage:[UIImage imageNamed:@"loading.png"] forState:UIControlStateNormal];
            [btnBrand.imageView setContentMode:UIViewContentModeScaleAspectFit];
            btnBrand.imageEdgeInsets=UIEdgeInsetsMake(10, 10, 50, 10);
            [btnBrand setBackgroundColor:[UIColor whiteColor]];
            [cfs setBorder:btnBrand];
            [btnBrand setTag:[[rec objectForKey:@"iRangeId"] intValue]];
           
            UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, btnBrand.imageView.frame.size.height, width-20, 80)];
            lblTitle.text =[rec objectForKey:@"vTitle"];
//            lblTitle.font =[UIFont fontWithName:@"HelveticaNeueBold" size:10];
            [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
            lblTitle.textColor = [UIColor grayColor];
            lblTitle.lineBreakMode=NSLineBreakByWordWrapping;
            lblTitle.numberOfLines=2;
            [lblTitle setTextAlignment:NSTextAlignmentCenter];
            NSString *title =[rec objectForKey:@"vTitle"];
            [btnBrand setTitle:[title stringByReplacingOccurrencesOfString:@" " withString:@"-"] forState:UIControlStateDisabled];
            
            [btnBrand addTarget:self action:@selector(btnRangeClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnBrand addSubview:lblTitle];
            [_scrBrand addSubview:btnBrand];
            
            NSArray *param= [[NSArray alloc]initWithObjects:[rec objectForKey:@"6"],btnBrand, nil];
            
            [self performSelectorInBackground:@selector(LoadImage:) withObject:param];
            
            
            cnt++;
            x+=width+10;
            if(cnt>2){
                x=10;
                y+=height+10;
                cnt=1;
                totalimg++;
            }
            
            
            //if(totalimg==2) break;
            
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



- (IBAction)btnRangeClick:(UIButton *)sender {
    
    

    
    //NSLog(@"%@ %@ %d %@",_brandId,_brandName,sender.tag,[sender titleForState:UIControlStateDisabled]);
    NSString *title =[sender titleForState:UIControlStateDisabled];
    _lblHead.text=[title stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    NSString *urlString =[NSString stringWithFormat:@"https://www.choicefurnituresuperstore.co.uk/%@-%@-%ld-r%@.html",_brandName,[sender titleForState:UIControlStateDisabled],(long)sender.tag,_brandId]; ;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_uvWeb loadRequest:urlRequest];
        _uvWeb.hidden=NO;
    
    [activityIndicator startAnimating];
    [overlay setHidden:NO];
    _btnBack.tag=2;
    

    
}

-(void)LoadImage:(NSArray *) sender{
    [cfs LoadImage:sender];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [overlay setHidden:YES];
    [activityIndicator stopAnimating];
}



@end
