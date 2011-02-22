//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Mark Beaty on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
	double operand;
	double memory;
	NSString *waitingOperation;
	double waitingOperand;
}

- (void)setOperand:(double)aDouble;
- (double)memory;
- (double)performOperation:(NSString *)operation;
- (void)performMemoryOperation:(NSString *)operation;
- (void)performClear;


@end
