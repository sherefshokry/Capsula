//
//  NSBundle+Language.m
//  Mansour
//
//  Created by SherifShokry on 12/25/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSBundle+Language.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
static const char kBundleKey = 0;

@interface BundleEx : NSBundle
    
    @end

@implementation BundleEx
    
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
    {
        NSBundle *bundle = objc_getAssociatedObject(self, &kBundleKey);
        if (bundle) {
            return [bundle localizedStringForKey:key value:value table:tableName];
        }
        else {
            return [super localizedStringForKey:key value:value table:tableName];
        }
    }
    
    @end

@implementation NSBundle (Language)
    
+ (void)setLanguage:(NSString *)language
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            object_setClass([NSBundle mainBundle],[BundleEx class]);
        });
        id value = language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil;
        objc_setAssociatedObject([NSBundle mainBundle], &kBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if([language isEqualToString:@"en"]){
            UIView.appearance.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;

        }else{
            UIView.appearance.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;

        }
        
    }
    
    @end
