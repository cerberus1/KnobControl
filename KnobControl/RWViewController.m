//
//  RWViewController.m
//  KnobControl
//
//  Created by Sam Davies on 14/11/2013.
//  Copyright (c) 2013 RayWenderlich. All rights reserved.
//

#import "RWViewController.h"
#import "RWKnobControl.h"

@interface RWViewController (){
    RWKnobControl *_knobControl;
}

@end

@implementation RWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _knobControl = [[RWKnobControl alloc] initWithFrame:self.knobPlaceholder.bounds];
    [self.knobPlaceholder addSubview:_knobControl];
    
    _knobControl.lineWidth = 4.0;
    _knobControl.pointerLength = 8.0;
  
//    _knobControl.minimumValue = 0.0;  //must be normalized (0-1) range for now.
//    _knobControl.maximumValue = 1.0;
    _knobControl.shape = 0.5;
    
    _knobControl.value = 0.5;
    
    // [ _knobControl setValue:<#(CGFloat)#> animated:<#(BOOL)#>
    
    
    [ _knobControl setValue:(_knobControl.value) animated:self.animateSwitch.on];
    [self.valueSlider setValue:_knobControl.value animated:self.animateSwitch.on];
    self.valueLabel.text = [NSString stringWithFormat:@"%0.2f", _knobControl.value];
    //[RWKnobControl  set:(0.0)];
    
    self.view.tintColor = [UIColor colorWithRed:(1.0) green:(0.5) blue:0.0 alpha:(1.0)];
    
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    
    // Hooks up the knob control
    [_knobControl addTarget:self
                     action:@selector(handleValueChanged:)
           forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleValueChanged:(id)sender {
    if(sender == self.valueSlider) {
        _knobControl.value = self.valueSlider.value;
    } else if(sender == _knobControl) {
        self.valueSlider.value = _knobControl.value;
    }
}

- (IBAction)handleRandomButtonPressed:(id)sender {
    // Generate random value
    CGFloat randomValue = (arc4random() % 101) / 100.f;
    // Then set it on the two controls
    [_knobControl setValue:randomValue animated:self.animateSwitch.on];    //[_knobControl setValue:randomValue animated:true];

    [self.valueSlider setValue:randomValue animated:self.animateSwitch.on];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if(object == _knobControl && [keyPath isEqualToString:@"value"]) {
        self.valueLabel.text = [NSString stringWithFormat:@"%0.2f", _knobControl.value];
    }
}

@end
