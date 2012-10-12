//
//  CalculatorViewController.m
//  TKCalculator
//
//  Created by Tiernan Kennedy on 25/09/2012.
//  Copyright (c) 2012 Tiernan Kennedy. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong)NSMutableArray *history;


@end

@implementation CalculatorViewController

@synthesize display;
@synthesize brainDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize history = _history;


- (CalculatorBrain *) brain
{
    // lazy instantiation
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

-(NSMutableArray *)history
{
    if(!_history) _history = [[NSMutableArray alloc] initWithCapacity:10];
    return _history;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if(self.userIsInTheMiddleOfEnteringANumber)
    {
    self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    if(self.history.count == 10)
    {
        [self.history removeObjectAtIndex:0];
        // remove the 10th last double entered
    }
    
    // display pi & e properly
    if([self.display.text isEqualToString:@"3.14159"])
        [self.history addObject:@"π"];
    else if([self.display.text isEqualToString:@"2.71828"])
        [self.history addObject:@"e"];
    else
        [self.history addObject:self.display.text];
    
    self.brainDisplay.text = [self.history componentsJoinedByString:@" "];
}


- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    if(self.history.count == 10)
        [self.history removeObjectAtIndex:0];
    
    // make exceptions for pi and e
    if(![operation isEqualToString:@"π"] &&![operation isEqualToString:@"e"])
    {
        [self.history addObject: sender.currentTitle];
    }
  
        self.brainDisplay.text = [[self.history componentsJoinedByString:@" "]stringByAppendingString:@" ="];
}

- (IBAction)dotPressed {
    if (!self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    } else {
        NSRange range = [self.display.text rangeOfString:@"." options:NSCaseInsensitiveSearch];
        if (range.location == NSNotFound)
            self.display.text = [self.display.text stringByAppendingString:@"."];
    }
}

- (IBAction)clearPressed:(id)sender {
    [self.brain clearAll];
    self.history = nil;
    self.display.text = @"0";
    self.brainDisplay.text = @" ";
    self.userIsInTheMiddleOfEnteringANumber = NO;

}

- (void)viewDidUnload {
    [self setBrainDisplay:nil];
    [super viewDidUnload];
}
@end
