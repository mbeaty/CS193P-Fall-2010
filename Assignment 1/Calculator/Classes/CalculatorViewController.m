//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Mark Beaty on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

static NSString * const DECIMAL_POINT = @".";

// Getter for brain instance variable; lazy instantiation

- (CalculatorBrain *)brain {
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
	return brain;
}
	
- (IBAction)digitPressed:(UIButton *)sender {
	NSString *digit = [[sender titleLabel] text];
	if (userIsInTheMiddleOfTypingANumber) {
		[display setText:[[display text] stringByAppendingString:digit]];
	}
	else {
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)decimalPressed:(UIButton *)sender {
	NSString *entered = [display text];
	if (userIsInTheMiddleOfTypingANumber) {
		if ([entered rangeOfString:DECIMAL_POINT].location == NSNotFound) {
			[display setText:[[display text] stringByAppendingString:DECIMAL_POINT]];
		}
	}
	else {
		[display setText:DECIMAL_POINT];
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)operationPressed:(UIButton *)sender {
	
	if (userIsInTheMiddleOfTypingANumber) {
		[[self brain] setOperand:[[display text] doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	NSString *operation = [[sender titleLabel] text];
	double result = [[self brain] performOperation:operation];
	// keeping it simple for the errors for now
	if (isnan(result)) {
		[display setText:@"Not a number"];
	} else if (isinf(result)) {
		[display setText:@"Division by zero"];
	} else {
    	[display setText:[NSString stringWithFormat:@"%g", result]];
	}
}

- (IBAction)memoryOperationPressed:(UIButton *)sender {
	
	NSString *operation = [[sender titleLabel] text];

	if ([operation isEqual:@"MR"]) {
		display.text = [NSString stringWithFormat:@"%g", [self brain].memory];
	}
	else {
		[[self brain] setOperand:[[display text] doubleValue]];
	}
	
	userIsInTheMiddleOfTypingANumber = NO;
	
	[[self brain] performMemoryOperation:operation];
}

- (IBAction)clearPressed:(UIButton *)sender {
	NSLog(@"Clear");
	userIsInTheMiddleOfTypingANumber = NO;
	[display setText:@"0"];
	[[self brain] performClear];
}


@end
