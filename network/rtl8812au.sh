#!/bin/bash

git clone https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au || exit

sudo apt-get install raspberrypi-kernel-headers

CPUINFO=$(cat /proc/cpuinfo)

if echo "$CPUINFO" | grep -q "3 Model B+" || echo "$CPUINFO" | grep -q "4 Model B"; then
  # for RPI 3B+ & 4B
  sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
  sed -i 's/CONFIG_PLATFORM_ARM64_RPI = n/CONFIG_PLATFORM_ARM64_RPI = y/g' Makefile
else
  # For RPI 1/2/3/ & 0/Zero
  sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
  sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
fi

make && make install

cd ..
