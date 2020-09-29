//
//  Shared.h
//  objc
//
//  Created by 002 on 2020/2/26.
//

#ifndef Shared_h
#define Shared_h

#define FHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define print_D(fmt, ...)    printf("[%s %d] " fmt"\n",__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#endif /* Shared_h */
