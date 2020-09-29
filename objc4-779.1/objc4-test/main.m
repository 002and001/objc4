//
//  main.m
//  objc4-test
//
//  Created by 002 on 2020/5/8.
//

#import <Foundation/Foundation.h>
#import "Animal.h"
#import "objc-config.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Animal *animal = [Animal alloc];
        animal.class;
        [Animal class];
        NSLog(@"Hello, World!");
        NSLog(@"__arm64__ is %d",__arm64__);
        NSLog(@"__LP64__ is %d",__LP64__);
    }
    return 0;
}
