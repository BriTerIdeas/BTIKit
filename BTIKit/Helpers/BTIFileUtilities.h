//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
#import <Foundation/Foundation.h>

// Classes and Forward Declarations

// Public Constants

// Protocols

@interface BTIFileUtilities : NSObject

// Public Properties

// Public Methods

// Directories
+ (NSURL *)documentsDirectoryURL;
+ (NSURL *)libraryDirectoryURL;
+ (NSURL *)cacheDirectoryURL;
+ (NSURL *)libraryApplicationSupportDirectoryURL;

@end
