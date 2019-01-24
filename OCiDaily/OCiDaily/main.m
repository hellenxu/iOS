//
//  main.m
//  OCiDaily
//
//  Created by Hellen on 2019-01-22.
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

    }
    
    return 0;
}
