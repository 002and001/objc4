# objc4
 可编译运行的objc4源码项目

#### 如何做到从官方下载的objc源码可编译运行呢？
官方提供的objc源码之所以不能编译运行，主要是因为依赖于其他库的一些文件，需要自己去找到对应库的依赖文件，然后添加到objc项目中并配置这些依赖，其次一些工程配置，比如sdk的依赖等也需要进行处理。
我这里提供了可编译的objc源码，大家可以直接在上面进行调试分析。

##### 注意环境问题
以下是我调试使用的环境  
* 750对应的是mac10.14，Xcode11.3  
* 779对应的是mac10.15，Xcode11.4  
* 781对应的是mac10.15.7，Xcode12.0.1（Xcode11.4以上即可）  
* 如果750源码运行在mac10.15，Xcode11.4上会出现问题，导致无法正常调试。建议根据环境选择不同版本的源码。

如果感兴趣想要自己从头配置，可以按如下步骤进行，以**779.1**版本源码为例：
* 去apple官网[开源地址](https://opensource.apple.com/tarballs/)下载objc-779.1源码
* 然后按如下图解进行配置

![image.png](https://upload-images.jianshu.io/upload_images/2351207-905fb08e2a7b9e81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



* 报错：unable to find sdk 'macosx.internal'
objc、objc-trampolines2个target都需要按下图设置
![image.png](https://upload-images.jianshu.io/upload_images/2351207-37362c91c8122d94.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* ![image.png](https://upload-images.jianshu.io/upload_images/2351207-f50660b7a15495e4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 剩下的配置都是对objc项目的
* 'sys/reason.h' file not found，类似的还有其他文件找不到
这是因为objc4依赖于其他库的源码，需要添加到项目中并设置搜索路径。相关文件都可以在官网源码地址找到，这里不一一贴出来了，大家可用从我的项目中拷贝[**common**文件夹]([https://github.com/002and001/objc4-779.1/tree/master/common](https://github.com/002and001/objc4-779.1/tree/master/common)
)添加到工程中然后按下图配置debug和release：
![image.png](https://upload-images.jianshu.io/upload_images/2351207-4e82bbd8480b661e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* objc-errors.h中报错：Use of undeclared identifier 'CRGetCrashLogMessage'
![image.png](https://upload-images.jianshu.io/upload_images/2351207-3a31ae5612eb7502.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 按下图配置添加宏定义**LIBC_NO_LIBCRASHREPORTERCLIENT**

![image.png](https://upload-images.jianshu.io/upload_images/2351207-9932f410a2b2535b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


* objc-runtime.h中报错：Mismatch in debug-ness macros
![image.png](https://upload-images.jianshu.io/upload_images/2351207-523d7ad3ad08fd9e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


注释掉objc-runtime.mm中的#error mismatch in debug-ness macros 
 
```  
/***********************************************************************
* _objc_isDebugBuild. Defined in debug builds only.
* Some test code looks for the presence of this symbol.
**********************************************************************/
#if DEBUG != OBJC_IS_DEBUG_BUILD
//#error mismatch in debug-ness macros
// DEBUG is used in our code. OBJC_IS_DEBUG_BUILD is used in the
// header declaration of _objc_isDebugBuild() because that header
// is visible to other clients who might have their own DEBUG macro.
#endif
```  

* ld: can't open order file: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/AppleInternal/OrderFiles/libobjc.order
解决办法：替换为${SRCROOT}/libobjc.order

![image.png](https://upload-images.jianshu.io/upload_images/2351207-071d177830027c01.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* library not found for -lCrashReporterClient
解决办法：删除Other linker Flags里的内容
![image.png](https://upload-images.jianshu.io/upload_images/2351207-664492a61ca0853d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2351207-f8c6f8659d59c0bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 配置更改xcrun依赖的sdk

把 **-sdk macosx.internal**改为**-sdk macosx**，

![image.png](https://upload-images.jianshu.io/upload_images/2351207-34b32702c54bda56.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


* 最后的配置
![image.png](https://upload-images.jianshu.io/upload_images/2351207-3ea4c234ee2f42a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/2351207-a862df3b5f6e8095.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 正确完成以上所有配置而且，即可用正常编译objc项目了。

#### 配置过程中的报错：
* /xcrun:1:1: unrecognized option: -Wall
原因是我在配置xcrun的依赖的时候，手误不小心把macosx.internal删除了，应该是把macosx.internal替换为macosx，编译重新运行就可以了。

#### 新建项目调试源码
* 新建一个macOS的command Line Tool项目，设置依赖就可以
![image.png](https://upload-images.jianshu.io/upload_images/2351207-e4b9a428107244df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 无法断点调试问题
升级到Xcode12.0.1后发现源码添加的断点不生效了，有时候在Target的main.m中添加的断点也断不住。可以参考以下对应方案来解决：
### 1.创建的target的main添加断点不生效
* Build Phases --> Compile Source中，将main文件移至第一位
* Build Settings --> Enable Hardened Runtime中，设置为NO
![image.png](https://upload-images.jianshu.io/upload_images/2351207-2cc4415b041b8de8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 2.objc4源码断点不生效
* Build Phases --> Compile Source中，将NSObject.mm文件移至第一位
* Build Settings --> Enable Hardened Runtime中，设置为NO
![image.png](https://upload-images.jianshu.io/upload_images/2351207-05ccdef2aee03e70.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)