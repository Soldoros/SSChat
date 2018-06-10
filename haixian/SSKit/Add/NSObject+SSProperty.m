//
//  NSObject+DEProperty.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "NSObject+SSProperty.h"
#import "EXTSynthesize.h"

@implementation NSObject (SSProperty)

@synthesizeAssociation(NSObject,object);
@synthesizeAssociation(NSObject,string);
@synthesizeAssociation(NSObject,model);
@synthesizeAssociation(NSObject,dataDic);
@synthesizeAssociation(NSObject,indexPath);

@synthesizeAssociation(NSObject,dataSource);
@synthesizeAssociation(NSObject,hfDataSource);



@synthesizeAssociation(UIViewController,phoneCallWebView);




@end
