//
//  STPPaymentEmailView.m
//  Stripe
//
//  Created by Jack Flintermann on 3/23/16.
//  Copyright © 2016 Stripe, Inc. All rights reserved.
//

#import "STPPaymentEmailView.h"
#import "STPEmailAddressValidator.h"

@interface STPPaymentEmailView()<UITextFieldDelegate>

@property(nonatomic, weak) UITextField *textField;
@property(nonatomic, weak) UIActivityIndicatorView *activityIndicator;
@property(nonatomic, weak) UIButton *nextButton;

@end

@implementation STPPaymentEmailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UITextField *textField = [[UITextField alloc] init];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.borderStyle = UITextBorderStyleBezel;
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        _textField = textField;
        [self addSubview:textField];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator = activityIndicator;
        [self addSubview:activityIndicator];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
        nextButton.enabled = NO;
        [nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
        _nextButton = nextButton;
        [self addSubview:nextButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _activityIndicator.center = self.center;
    _textField.frame = CGRectMake(0, 0, self.bounds.size.width - 40, 44);
    _textField.center = CGPointMake(self.center.x, CGRectGetMinY(_activityIndicator.frame) - 50);
    [_nextButton sizeToFit];
    _nextButton.center = CGPointMake(self.center.x, CGRectGetMaxY(_activityIndicator.frame) + 50);
}

- (void)nextPressed:(__unused id)sender {
    [self.activityIndicator startAnimating];
    [self.delegate paymentEmailView:self didEnterEmailAddress:self.textField.text completion:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            [self.activityIndicator stopAnimating];
            return;
        }
    }];
}

- (void)textFieldDidChange {
    self.nextButton.enabled = [STPEmailAddressValidator stringIsValidEmailAddress:self.textField.text];
}

- (BOOL)canBecomeFirstResponder {
    return [self.textField canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder {
    return [self.textField canResignFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.textField resignFirstResponder];
}

@end
