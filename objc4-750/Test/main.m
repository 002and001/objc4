//
//  main.m
//  Test
//
//  Created by 002 on 2020/2/26.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Teacher.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
//#include <objc-runtime-new.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *person = [Person alloc];
        Person *person2 = [Person new];
        Teacher *teacher = [Teacher alloc];
        /**
         我们要查看[Person class]的地址，即类的地址
         [Person class]返回的是一个Class对象，根据源码Class对象实际上就是struct objc_class *类型
         相当于把struct objc_class *p = [Person class]
         分解为 1.struct objc_class person = [Person class]
               2.struct objc_class *p = &person;
         */
        FHLog(@"[Person class] is %p ",[Person class]);
        FHLog(@"class_getInstanceSize: is %ld ",class_getInstanceSize([person class]));
        FHLog(@"malloc_size:%ld ",malloc_size((__bridge const void*)person));
//        FHLog(@"teacher'size is %ld ",class_getInstanceSize(Teacher.class));
//        FHLog(@"teacher'size is %zd ",malloc_size((__bridge const void*)teacher));
        
//        struct cache_t c = {};
        FHLog(@"cache_t'size is %d" , sizeof(uint32_t));
    }
    return 0;
}
