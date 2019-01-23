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
    }
    
    return 0;
}
