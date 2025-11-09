obj-m += hello.o 
#告诉 kernel build system：把 hello.c/hello.o 作为一个模块构建（obj-m 表示模块对象）。内核构建系统识别 obj-m 并生成 hello.ko。
KDIR := /lib/modules/$(shell uname -r)/build
#指定内核源码/headers 的构建目录（通常是指向 /usr/src/linux-headers-$(version) 的符号链接）。这是内核提供的编译环境位置。我们是为本机编译驱动，因此只需要获得本机的路径
PWD := $(shell pwd)
#当前工作目录，传给内核 build 系统，告诉它在哪个目录查找模块源并把生成的对象放回本目录。
all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules
#用内核的 Makefile（-C (KDIR)）来构建模块，参数M=(KDIR)）来构建模块，参数M=(PWD) 表示模块代码位于外部目录，由 kernel build system 负责配置编译器、flags、内核生成头等。你不直接调用 gcc 来编译内核模块，而是借助 kernel 的构建流程来保证使用正确的编译器选项和生成头。
clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
#使用内核的 clean 规则清理模块生成的中间文件。
# convenience targets (optional)
load: all
	sudo insmod $(PWD)/hello.ko
#便捷 target：先构建，再以 root 加载模块。
unload:
	sudo rmmod hello || true
#卸载模块（不报错就静默）
dmesg:
	dmesg | tail -n 40
#快速查看最新内核日志（用于验证你的 printk 输出和模块加载/卸载消息）。