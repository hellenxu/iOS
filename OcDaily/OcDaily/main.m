//
//  main.m
//  OcDaily
//
//  Created by Hellen on 2019-01-28.
//  Copyright © 2019 Six. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int sum = 10 + 20;
        NSLog(@"The sum of 10 and 20 is %i", sum);
        NSLog(@"Color is %#x", 0xFFEF0D);
        NSLog(@"integerVar = %i", 50);
        NSLog(@"floatVar = %f", 331.98);
        NSLog(@"doubleVar = %e", 8.44e+11);
        NSLog(@"doubleVar = %g", 8.44e+11);
        NSLog(@"charVar = %c", 'W');
        NSLog(@"%c, %c", 120, 121);
        NSLog(@"%i, %i", 120, 121);
        
        //expression basic 1
        int a = 100;
        int b = 2;
        int c = 20;
        int d = 4;
        
        NSLog(@"a - b = %i", a - b);
        NSLog(@"b * c = %i", b * c);
        NSLog(@"a / b = %i", a / c);
        NSLog(@"a * b + c * d = %i", a * b + c * d);
        
        //expression basic 2
        a = 25;
        float e = 25.0;
        float f = 2.0;
        NSLog(@"6 + a / 5 * b = %i", 6 + a / 5 * b);
        NSLog(@"a / b * b = %i", a / b * b);
        NSLog(@"e / f * f = %f", e / f * f);
        NSLog(@"-a = %i", -a);
        
        //expression basic 3
        b = 5; c = 10; d = 7;
        NSLog(@"a %% b = %i", a % b);
        NSLog(@"a %% c = %i", a % c);
        NSLog(@"a %% d = %i", a % d);
        NSLog(@"a / d * d + a %% d = %i", a / d * d + a % d);
        
        //expression basic 4
        float f1 = 123.125, f2;
        int i1, i2 = -150;
        i1 = f1;
        NSLog(@"%f assigned to an int produces %i", f1, i1);
        f1 = i2;
        NSLog(@"%i assigned to a float produces %f", i2, f1);
        f1 = i2 / 100;
        NSLog(@"%i divided by 100 produces %f", i2, f1);
        f2 = i2 / 100.0;
        NSLog(@"%i divided by 100.0 produces %f", i2, f2);
        
        //expression basic 5
        unsigned int w1 = 0xA0A0A0A0, w2 = 0xFFFF0000, w3 = 0x00007777;
        NSLog(@"%x %x %x", w1 & w2, w1 | w2, w1 ^ w2);
        NSLog(@"%x %x %x", ~w1, ~w2, ~w3);
        NSLog(@"%x %x %x", w1 & ~w2, w1 | w2 | w3, w1 ^ w1);
        NSLog(@"%x %x", (w1 | w2) & w3, (w1 | w2) & ~ w3);
        NSLog(@"%x %x", ~(~w1 & ~w2), ~(~w1 | ~w2));
        
    }
    
    return 0;
}
