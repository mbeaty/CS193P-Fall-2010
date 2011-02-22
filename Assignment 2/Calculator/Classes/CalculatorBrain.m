//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Mark Beaty on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
NSMutableArray *expression;
@end

@implementation CalculatorBrain

@synthesize operand;  // readwrite, but controller only calls setter
@synthesize memory;  // readonly

- (void)setOperand:(double) theOperand {
	operand = theOperand;
	[expression addObject:[NSNumber numberWithDouble:operand]];
	
}
	
- (id)expression {
	// follow memory management rules; autorelease returned object
	return [[expression copy] autorelease];
}

- (id)init {
	if (self = [super init]) {
		expression = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)performWaitingOperation { 
	NSLog(@"performWaitingOperation: %g", operand);

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
	
// ???? retain operation and release in dealloc?
- (double)performOperation:(NSString *)operation {
	if ([self hasVariablesInExpression]) {
		[expression addObject:operation];
	}
	else {
		
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
			NSLog(@"performOperation: waitingOperation = %@, waitingOperand = %g", waitingOperation, waitingOperand);
		}
	}
	
	return operand;
}

- (void)setVariableAsOperand:(NSString *)variableName {
	[expression addObject:[NSString stringWithFormat:@"%%%@", variableName ]];
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


- (void) dealloc {
	// TBD
	[super dealloc];
}


+ (double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables {
	return 0;
}

+ (NSSet *)variablesInExpression:(id)anExpression {
	NSMutableSet *varSet = nil;
	for (id item in expression) {
		if (([item isKindOfClass:[NSString class]]) && 
			([item characterAtIndex:0] == '%') && 
			([item length] > 1)) {
			if (varSet == nil) {
				varSet = [[NSMutableSet alloc] init];
			}
			[varSet addObject:item];
		}
	}
			
	return [varSet autorelease];
}

- (BOOL)hasVariablesInExpression {
	NSSet *vars = [CalculatorBrain variablesInExpression:expression];
	return (vars ? YES : NO);
}

+ (NSString *)descriptionOfExpression:(id)anExpression {
	NSString *expressionDescription = @"expression";
//	for (id item in expression) {
//		expressionDescription = [NSString 
//	}
	
	return expressionDescription; //[expressionDescription autorelease];
}

+ (id)propertyListForExpression:(id)anExpression {
	return nil;
}

+ (id)expressionForPropertyList:(id)propertyList { 
	return nil;
}



@end
