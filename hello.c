/****************头文件**********/
#include <linux/init.h>    // 包含模块初始化/退出宏
#include <linux/module.h>  // 包含模块宏与信息
#include <linux/kernel.h>  // 包含 KERN_* 日志级别等（例如 KERN_ALERT）
#include <linux/kern_levels.h>

/****************功能实现**********/
static int __init hello_init(void)//模块加载函数
{
    printk("Hello, World!\n");//打印信息到内核日志
    return 0;//返回0表示成功加载模块
}

static void __exit hello_exit(void)//模块卸载函数
{
    printk("Goodbye, World!\n");//打印信息到内核日志
}


/****************模块驱动的入口和出口函数**********/
module_init(hello_init); // 模块加载函数入口
module_exit(hello_exit); // 模块卸载函数出口


/***************声明信息**********/
MODULE_LICENSE("GPL");//声明模块的许可证
MODULE_AUTHOR("Guxinxu");//声明模块的作者


