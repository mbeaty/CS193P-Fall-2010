//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Mark Beaty on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController() 
@property (nonatomic, retain) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize brain;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.brain = [[CalculatorBrain alloc] init];
}
	
- (IBAction)digitPressed:(UIButton *)sender {
	NSString *digit = sender.titleLabel.text;
		
	if (userIsInTheMiddleOfTypingANumber) {
		numberBeingEntered = [numberBeingEntered stringByAppendingString:digit];
		if ([self.brain hasVariablesInExpression] == NO) {
			display.text = numberBeingEntered; //[display.text stringByAppendingString:digit];
		}
	}
	else {
		numberBeingEntered = digit;
		if ([self.brain hasVariablesInExpression] == NO) {
			display.text = numberBeingEntered; //digit;
		}
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)decimalPressed:(UIButton *)sender {
		
	NSString *entered = display.text;
	
	if (userIsInTheMiddleOfTypingANumber) {
		if ([entered rangeOfString:@"."].location == NSNotFound) {
			numberBeingEntered = [numberBeingEntered stringByAppendingFormat:@"."];
			if ([self.brain hasVariablesInExpression] == NO) {
				display.text = numberBeingEntered; //[display.text stringByAppendingString:@"."];
			}
		}
	}
	else {
		numberBeingEntered = @".";
		if ([self.brain hasVariablesInExpression] == NO) {
			display.text = @".";
		}
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)operationPressed:(UIButton *)sender {
	NSString *operation = sender.titleLabel.text;
	
	if (userIsInTheMiddleOfTypingANumber) {
		[self.brain setOperand:[numberBeingEntered doubleValue]]; //[display.text doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	double result = [self.brain performOperation:operation];
	if ([self.brain hasVariablesInExpression]) {
		display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
	}
	else {
		display.text = [NSString stringWithFormat:@"%g", result];
	}
}

- (IBAction)memoryOperationPressed:(UIButton *)sender {
	
	if ([self.brain hasVariablesInExpression] == NO) {
		
		NSString *operation = sender.titleLabel.text;
		
		if ([operation isEqual:@"MR"]) {
			display.text = [NSString stringWithFormat:@"%g", self.brain.memory];
		}
		else {
			[self.brain setOperand:[display.text doubleValue]];
		}
		
		userIsInTheMiddleOfTypingANumber = NO;
		
		[self.brain performMemoryOperation:operation];
	}
}

- (IBAction)clearPressed:(UIButton *)sender {
	NSLog(@"Clear");
	userIsInTheMiddleOfTypingANumber = NO;
	display.text = @"0";
	[self.brain performClear];
}

- (IBAction)variableEntered:(UIButton *)sender {
	//if (equationModeOn) {
	NSString *variable = sender.titleLabel.text;
	[self.brain setVariableAsOperand:variable];
	NSLog(@"Variable %@ entered", variable);

	//}
}

- (IBAction)modePressed:(UIButton *)sender {
	NSLog(@"mode");
	NSString *select = sender.titleLabel.text;
	if ([select isEqual:@"Mode"]) {
		[modeSelect setTitle:@"Solve" forState:UIControlStateNormal];
		mode.text = @"Eq";
		display.text = @"0";
		equationModeOn = YES;
	}
	else {
		[modeSelect setTitle:@"Mode" forState:UIControlStateNormal];
		mode.text = nil;
		equationModeOn = NO;
	}
}

- (void)dealloc {
	self.brain = nil;
	[super dealloc];
}


@end
