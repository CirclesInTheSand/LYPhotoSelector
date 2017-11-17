//
//  NullSafe.m
//
//  Version 1.2.2
//
//  Created by Nick Lockwood on 19/12/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/NullSafe
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>


#ifndef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif


#pragma GCC diagnostic ignored "-Wgnu-conditional-omitted-operand"


@implementation NSNull (NullSafe)

#if NULLSAFE_ENABLED

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    @synchronized([self class])
    {
        //look up method signature
        NSMethodSignature *signature = [super methodSignatureForSelector:selector];
        if (!signature)
        {
            //not supported by NSNull, search other classes
            static NSMutableSet *classList = nil;
            static NSMutableDictionary *signatureCache = nil;
            if (signatureCache == nil)
            {
                classList = [[NSMutableSet alloc] init];
                signatureCache = [[NSMutableDictionary alloc] init];
                
                //get class list
                int numClasses = objc_getClassList(NULL, 0);/*获取到当前注册的所有类的总数*/
                Class *classes = (Class *)malloc(sizeof(Class) * (unsigned long)numClasses);/*开辟numClasses个类的内存给classes*/
                numClasses = objc_getClassList(classes, numClasses); /*向已分配好内存空间的数组 classes 中存放元素,即把这些类装到classes指向的内存里面去*/
                
                //add to list for checking
                NSMutableSet *excluded = [NSMutableSet set];
                for (int i = 0; i < numClasses; i++)
                {
                    //determine if class has a superclass
                    Class someClass = classes[i];//从classes的内存中取出第i个类
                    Class superclass = class_getSuperclass(someClass);//获取第i个类的父类
                    while (superclass) //如果父类存在
                    {
                        if (superclass == [NSObject class])
                        {
                            [classList addObject:someClass];//若这个类的根类是NSObject类型的，则加入NSMutableSet classList
                            break;
                        }
                        //若父类不为NSObject class, 则将父类的字符串存进NSMutableSet excluded
                        [excluded addObject:NSStringFromClass(superclass)];
                        //继续获取这个父类的父类
                        superclass = class_getSuperclass(superclass);
                    }
                }

                //remove all classes that have subclasses
                /*移除所有有子类的类。。我曹这是要干吗*/
                for (Class someClass in excluded)
                {
                    if([classList containsObject:someClass])
                    {
                        NSLog(@"233333");
                        [classList removeObject:someClass];
                    }
                }
                //此时classList里面的类都是继承自NSObject

                //free class list 将开辟的类的内存释放掉
                free(classes);
            }
            
            //check implementation cache first
            NSString *selectorString = NSStringFromSelector(selector);
            signature = signatureCache[selectorString];
            if (!signature)
            {
                //find implementation
                for (Class someClass in classList)
                {
                    if ([someClass instancesRespondToSelector:selector])
                    {
                        signature = [someClass instanceMethodSignatureForSelector:selector];
                        break;
                    }
                }
                
                //cache for next time
                signatureCache[selectorString] = signature ?: [NSNull null];
            }
            else if ([signature isKindOfClass:[NSNull class]])
            {
                signature = nil;
            }
        }
        return signature;
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = nil;
    [invocation invoke];
}

#endif

@end
