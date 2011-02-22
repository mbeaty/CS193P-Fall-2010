//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Mark Beaty on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	@private
	CalculatorBrain *brain;
	IBOutlet UILabel *display;
	IBOutlet UIButton *modeSelect;
	IBOutlet UILabel *mode;
	BOOL userIsInTheMiddleOfTypingANumber;
	BOOL equationModeOn;
	NSString *numberBeingEntered;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)decimalPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)variableEntered:(UIButton *)sender;
- (IBAction)memoryOperationPressed:(UIButton *)sender;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)modePressed:(UIButton *)sender;


@end

