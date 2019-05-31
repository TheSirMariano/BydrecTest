//
//  NSString+ComposedRange.h
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/31/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

#import <Foundation/Foundation.h>

// trying to fix the emoji error 
@interface NSString (ComposedRange)

  - (NSString *)composedSubstringWithRange:(NSRange)range;
  
@end

