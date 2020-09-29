//
//  main.m
//  MyTest
//
//  Created by 002 on 2020/9/29.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Person *p1 = [[Person alloc] init];
        
        NSLog(@"Hello, World!,p1:%p",[p1 class]);
    }
    return 0;
}
