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

@property (readwrite, assign) double operand;
@property (readonly, assign) double memory;
@property (readonly) id expression;

- (double)performOperation:(NSString *)operation;
- (void)performMemoryOperation:(NSString *)operation;
- (void)performClear;
- (void)setVariableAsOperand:(NSString *)variableName;

+ (double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables;

+ (NSSet *)variablesInExpression:(id)anExpression;
- (BOOL)hasVariablesInExpression;

+ (NSString *)descriptionOfExpression:(id)anExpression;

+ (id)propertyListForExpression:(id)anExpression;
+ (id)expressionForPropertyList:(id)propertyList;

@end
