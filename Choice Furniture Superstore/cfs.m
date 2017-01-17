//
//  cfs.m
//  Choice Furniture Superstore
//
//  Created by Admin on 17/10/1938 Saka.
//  Copyright © 1938 Saka CFS Furniture. All rights reserved.
//

#import "cfs.h"


@implementation cfs


+(void)setBorder:(UIControl *)control{
    [control.layer setBorderWidth:1];
    [control.layer setBorderColor:[[UIColor colorWithRed:233/255.0f green:233/255.0f blue:233/255.0f alpha:0.1f] CGColor]];
    
    control.layer.shadowRadius = 3.0f;
    control.layer.shadowColor = [[UIColor colorWithRed:104/255.0f green:104/255.0f blue:104/255.0f alpha:0.1f] CGColor];
    control.layer.shadowOffset = CGSizeMake(2, 2);
    control.layer.shadowOpacity = 1;
    control.layer.masksToBounds = NO;
}


+(void)LoadImage:(NSArray *) sender
{
    NSURL *imgURL=[NSURL URLWithString:sender[0]];
    NSData *imgData=[NSData dataWithContentsOfURL:imgURL];
    [sender[1] setImage:[UIImage imageWithData:imgData] forState:UIControlStateNormal];
    
}


@end
