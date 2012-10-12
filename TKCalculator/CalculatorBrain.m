//
//  CalculatorBrain.m
//  TKCalculator
//
//  Created by Tiernan Kennedy on 25/09/2012.
//  Copyright (c) 2012 Tiernan Kennedy. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;
// nonatomic - not thread safe

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    // lazy instantiation
    if (!_operandStack)
    {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    // NSNumber wraps primitive objects into objects
    [self.operandStack addObject:operandObject];
}

- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject)
    {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}


- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    else if ([@"*" isEqualToString:operation])
    {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    }
    else if([operation isEqualToString:@"sin"])
    {
        double operand = [self popOperand];
        operand = (operand * M_PI/180); // convert to radians
        result = sin(operand);
    }
    else if([operation isEqualToString:@"cos"])
    {
        double operand = [self popOperand];
        operand = (operand * M_PI/180); // convert to radians
        result = cos(operand);
    }
    else if([operation isEqualToString:@"sqrt"])
    {
        double operand = [self popOperand];
        result = sqrt(operand);
    }
    else if([operation isEqualToString:@"π"])
    {
        result = M_PI;
    }
    else if([operation isEqualToString:@"+/-"])
    {
        result = (-1.0)*[self popOperand];
    }
    else if ([operation isEqualToString:@"log"]) {
        double operand = [self popOperand];
        result = log([self popOperand]);
    }
    else if([operation isEqualToString:@"e"])
    {
        result = M_E;
    }
    
    [self pushOperand:result];
    
    return result;
}

-(void)clearAll
{
    self.operandStack = nil;
    
}

@end
