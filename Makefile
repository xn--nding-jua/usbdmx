CC              = arm-linux-gnueabi-gcc
CXX             = arm-linux-gnueabi-g++
OBJS            = $(COBJS) $(CPPOBJS)
CFLAGS          += -Wall -g -c -fpic -pthread
COBJS           = hid.o usbdmx.o
LIBS            = -pthread -ludev
LD_SHARED       = -shared

all: libusbdmx.so

clean:
	rm -f $(OBJS) libusbdmx.so

libusbdmx.so: $(OBJS)
	$(CC) $(OBJS) $(LD_SHARED) -s -o libusbdmx.so $(LIBS)

libusbdmx.a: usbdmx.o
	ar rcs libusbdmx.a usbdmx.o

$(COBJS): %.o: %.c
	$(CC) $(CFLAGS) $< -o $@

$(CPPOBJS): %.o: %.cpp
	$(CXX) $(CFLAGS) $< -o $@

.PHONY: clean
