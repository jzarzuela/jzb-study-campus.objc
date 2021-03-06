//
//  POIData.m
//  JZBTest
//
//  Created by Snow Leopard User on 15/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "POIData.h"
#import "JavaStringCat.h"


@implementation POIData


@synthesize name, desc, lng, lat, iconStyle, category;


//****************************************************************************
- (id)init
{
    self = [super init];
    if (self) {
        name = @"";
        desc = @"";
        iconStyle = @"";
        category = UNKNOWN_CATEGORY;
    }
    
    return self;
}

//****************************************************************************
- (void)dealloc
{
    // @TODO:  ¿Hace falta esto?
    [name autorelease];
    [desc autorelease];
    [iconStyle autorelease];
    [category autorelease];
    [super dealloc];
}

/****************************************************************************
 * Utility method that extracts a "simplified" category name from the iconStyle attribute (url).
 * It is simplier to read that information than the whole one in iconStyle
 **/
+ (NSString *) calcCategoryFromIconStyle: (NSString *)iconStyle {
    
    NSString *catName;
    
    //-----------------------------------------------------------
    if(iconStyle == nil || [iconStyle length] == 0) {
        
        return UNKNOWN_CATEGORY;
        
    } 
    //-----------------------------------------------------------
    else if([iconStyle indexOf:@"chst=d_map_pin_letter"] != NSNotFound) {
        
        NSUInteger p1 = [iconStyle lastIndexOf:@"chld="];
        if(p1 != NSNotFound) {
            
            NSUInteger p2 = [iconStyle lastIndexOf:@"|" startIndex:p1];
            if(p2 == NSNotFound) {
                p2 = [iconStyle length];
            }
            
            catName = [NSString stringWithFormat:@"Pin_Letter_%@", [iconStyle subStrFrom: p1+5 To:p2]];
            catName = [catName replaceStr:@"|" Width:@"_"];
            
            return catName;
            
        } else {
            return [iconStyle copy];
        }
    }
    //-----------------------------------------------------------
    else if([iconStyle indexOf:@"/kml/paddle"] != NSNotFound) {
        
        NSUInteger p1 = [iconStyle lastIndexOf:@"/"];
        if(p1 != NSNotFound) {
            
            NSUInteger p2 = [iconStyle lastIndexOf:@"_maps" startIndex:p1];
            if(p2 == NSNotFound) {
                p2 = [iconStyle length];
            }
            
            catName = [NSString stringWithFormat:@"Pin_Letter_%@", [iconStyle subStrFrom: p1+1 To:p2]];
            
            return catName;
            
        } else {
            return [iconStyle copy];
        }
    }
    //-----------------------------------------------------------
    else if([iconStyle indexOf:@"/mapfiles/ms/micons"] != NSNotFound || [iconStyle indexOf:@"/mapfiles/ms2/micons"] != NSNotFound) {
        
        NSUInteger p1 = [iconStyle lastIndexOf:@"/"];
        if(p1 != NSNotFound) {
            
            NSUInteger p2 = [iconStyle lastIndexOf:@"." startIndex:p1];
            if(p2 == NSNotFound) {
                p2 = [iconStyle length];
            }
            
            catName = [NSString stringWithFormat:@"GMI_%@", [iconStyle subStrFrom: p1+1 To:p2]];
            
            return catName;
            
        } else {
            return [iconStyle copy];
        }
    }
    //-----------------------------------------------------------
    else if([iconStyle indexOf:@"/kml/shapes"] != NSNotFound) {
        
        NSUInteger p1 = [iconStyle lastIndexOf:@"/"];
        if(p1 != NSNotFound) {
            
            NSUInteger p2 = [iconStyle lastIndexOf:@"_maps" startIndex:p1];
            if(p2 == NSNotFound) {
                p2 = [iconStyle length];
            }
            
            catName = [NSString stringWithFormat:@"GMI_%@", [iconStyle subStrFrom: p1+1 To:p2]];
            
            return catName;
            
        } else {
            return [iconStyle copy];
        }
    }
    //-----------------------------------------------------------
    else {
        return UNKNOWN_CATEGORY;
    }
    
    
}

//****************************************************************************
- (void) dump {
    NSLog(@"POIData name='%@' desc='%@' lng='%f' lat='%f' category='%@' iconStyle='%@'",name,desc,lng,lat,category,iconStyle);
}


//****************************************************************************
@end
