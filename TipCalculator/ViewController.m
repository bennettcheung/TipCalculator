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
- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.2f", sender.value];
     [self calculateTip:self.calculateTipButton];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self calculateTip:self.calculateTipButton];
    return YES; // want to hide keyboard

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *allowedCharacters = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
    
    if([string rangeOfCharacterFromSet:allowedCharacters.invertedSet].location == NSNotFound){
        [self calculateTip:self.calculateTipButton];
        return YES;
        
    }
    
    return NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

@end
