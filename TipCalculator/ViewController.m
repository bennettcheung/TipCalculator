//
//  ViewController.m
//  TipCalculator
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UIButton *calculateTipButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tipAmountLabel.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
    
    
    float tip = [self.billAmountTextField.text floatValue] * [self.tipPercentageTextField.text floatValue]/100;
    self.tipAmountLabel.text =  [NSString stringWithFormat:@"$ %.2f", tip];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self calculateTip:self.calculateTipButton];
    return YES; // want to hide keyboard

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *allowedCharacters = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
    
    if([string rangeOfCharacterFromSet:allowedCharacters.invertedSet].location == NSNotFound){
        
        return YES;
        
    }
    
    return NO;
    
}
@end
