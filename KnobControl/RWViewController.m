//
//  RWViewController.m
//  KnobControl
//
//  Created by Sam Davies on 14/11/2013.
//  Copyright (c) 2013 RayWenderlich. All rights reserved.
//

#import "RWViewController.h"
#import "RWKnobControl.h"

#define BOUNDED(x,lo,hi) ((x) < (lo) ? (lo) : (x) > (hi) ? (hi) : (x))

@interface RWViewController (){
    RWKnobControl *_knobControl;
}

@end


double ToNormalizedParam(double nonNormalizedValue, double min, double max, double shape)
{
    return pow((nonNormalizedValue - min) / (max - min), 1.0 / shape);
}

@implementation RWViewController

double m_knobControlMin = 0.0;
double m_knobControlMax = 1.0;
bool m_isNormalized = true;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _knobControl = [[RWKnobControl alloc] initWithFrame:self.knobPlaceholder.bounds];
    [self.knobPlaceholder addSubview:_knobControl];
    
    // set some defaults
    _knobControl.lineWidth = 4.0;
    _knobControl.pointerLength = 8.0;
  
    _knobControl.minimumValue = _valueSlider.minimumValue = -1.0;  //comment out for normalized (0.0-1.0) range.
    _knobControl.maximumValue = _valueSlider.maximumValue = 1.0; //comment out for normalized range.
    _knobControl.shape = 0.5;   // works for normalized only (comment out above 2 lines)
    
    _knobControl.value = 0.5;  // set initial value
    
    // [ _knobControl setValue:<#(CGFloat)#> animated:<#(BOOL)#>
  //  double tempvalue = _knobControl.value;
    
//    if(m_knobControlMax != 1.0 || m_knobControlMin != 0.0){ // if non-normalized, convert tempvalue to normalized.
//        
//        m_isNormalized = false;
//        tempvalue  = BOUNDED(_knobControl.value, m_knobControlMin, m_knobControlMax);
//        tempvalue = ToNormalizedParam(tempvalue, m_knobControlMin, m_knobControlMax, _knobControl.shape);
//    }
    
    [ _knobControl setValue:(_knobControl.value) animated:self.animateSwitch.on];
    [self.valueSlider setValue:_knobControl.value animated:self.animateSwitch.on];
    [self updateValueLabel:_knobControl.value];
    //[RWKnobControl  set:(0.0)];
    
    self.view.tintColor = [UIColor colorWithRed:(1.0) green:(0.5) blue:0.0 alpha:(1.0)];
    
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    
    // Hooks up the knob control
    [_knobControl addTarget:self
                     action:@selector(handleValueChanged:)
           forControlEvents:UIControlEventValueChanged];
}

- (void)updateValueLabel:(double)value

{
    
    self.valueLabel.text = [NSString stringWithFormat:@"%0.2f", value];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleValueChanged:(id)sender {
    
//    double tempvalue = _knobControl.value;
//    
//    if(m_knobControlMax != 1.0 || m_knobControlMin != 0.0){ // if non-normalized, convert tempvalue to normalized.
//        
//        m_isNormalized = false;
//        tempvalue  = BOUNDED(_knobControl.value, m_knobControlMin, m_knobControlMax);
//        tempvalue = ToNormalizedParam(tempvalue, m_knobControlMin, m_knobControlMax, _knobControl.shape);
//    }
    
    
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
       
        [self updateValueLabel:_knobControl.value];
    }
}

@end
