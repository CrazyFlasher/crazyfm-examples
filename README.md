##CrazyFM Official Examples
Current repository contains official examples of [CrazyFM](https://github.com/CrazyFlasher/crazyfm) framework.
Description of each example is described in example folder.

###Build from source (Windows)
To build all examples to swf files you need to:

1. Install **ANT**
2. Install [Apache Flex SDK](http://flex.apache.org/)
3. Specify environment variables:
  - **ANT_HOME** - path to ant.bat
  - **FLASH_PLAYER_EXE** - path to flash standalone exe
  - **FLASH_IDE_EXE** - (optional) path to Flash.exe (Animate.exe)
  - **FLEX_HOME** - path to Flex SDK
  - **_JAVA_OPTIONS** - -Xmx512M -XX:MaxPermSize=512m
4. Open CMD and target to **/crazyfm-examples/** folder
5. Type **ant** and build process will start
6. When build finish with success result, all compiled examples will appear here: **/crazyfm-examples/out/**