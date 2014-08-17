//
//  NSString+BTIKitAdditions.h
//  BTIKit
//  v1.1
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import <Foundation/Foundation.h>

@interface NSString (BTIKitAdditions)

/** Passes directly through to writeToURL:atomically:encoding:error:
 */
- (BOOL)writeToURLBTI:(NSURL *)url atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc;

/**
 Returns whether the receiver is empty
 
 @return YES if the receiver has contents, otherwise NO.
 */
- (BOOL)isNotEmptyBTI;

/**
 Returns whether the receiver is a valid email address
 
 @return YES if the receiver has is a valid email address, otherwise NO.
 */
- (BOOL)isValidEmailAddressBTI;


@end
