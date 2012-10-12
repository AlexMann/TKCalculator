//
//  CalculatorBrain.h
//  TKCalculator
//
//  Created by Tiernan Kennedy on 25/09/2012.
//  Copyright (c) 2012 Tiernan Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void) clearAll;

@end
