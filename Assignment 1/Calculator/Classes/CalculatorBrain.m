//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Mark Beaty on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain
- (void)setOperand:(double)aDouble {
	operand = aDouble;
}

- (double)memory {
	return memory;
}

- (void)performWaitingOperation { 
	if ([@"+" isEqual:waitingOperation]) { 
		operand = waitingOperand + operand; 
	} else if ([@"x" isEqual:waitingOperation]) {
		operand = waitingOperand * operand;
	} else if ([@"-" isEqual:waitingOperation]) { 
		operand = waitingOperand - operand;
	} else if ([@"/" isEqual:waitingOperation]) {
		if (operand) {  // fail quietly on divide by 0 for now
			operand = waitingOperand / operand;
		}
	} 
}
	
- (double)performOperation:(NSString *)operation {
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	} else if ([operation isEqual:@"sin"]) {
		operand = sin(operand);
	} else if ([operation isEqual:@"cos"]) {
		operand = cos(operand);
	} else if ([operation isEqual:@"+/-"]) {
		operand = -operand;
	} else if ([operation isEqual:@"1/x"]) {
		operand = 1 / operand;
	}
	else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}
	
	return operand;
}

/* - (double)performOperation:(NSString *)operation {
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	} else {
		if ([waitingOperation isEqual:@"*"] || 
			[waitingOperation isEqual:@"/"] ||
			[operation isEqual:@"="]) {
			NSLog(@"waitingOperation is %@", waitingOperation);
			NSLog(@"waitingOperand is %g", waitingOperand);

			[self performWaitingOperation];
		}
		waitingOperation = operation;
		waitingOperand = operand;
		
		NSLog(@"waitingOperation is %@", waitingOperation);
		NSLog(@"waitingOperand is %g", waitingOperand);

	}

	return operand;
}
 */

- (void)performMemoryOperation:(NSString *)operation {
	if ([operation isEqual:@"MC"]) {
		memory = 0;
	} else if ([operation isEqual:@"M+"]) {
		memory += operand;
	} else if ([operation isEqual:@"M-"]) {
		memory -= operand;
	} else if ([operation isEqual:@"MR"]) {
		operand = memory;
	} 	
}

- (void) performClear {
	operand = 0;
	waitingOperand = 0;
	waitingOperation = nil;	
}

@end
