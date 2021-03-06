//
// XMLReader.h
//
// Created by Troy on 9/18/10.
// Copyright 2010 Troy Brant. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SimpleXMLReader : NSObject <NSXMLParserDelegate>

+ (NSDictionary *) dictionaryForXMLData:(NSData *)data error:(NSError * __autoreleasing *)errorPointer;
+ (NSDictionary *) dictionaryForXMLString:(NSString *)string error:(NSError * __autoreleasing *)erorPointer;

@end
