# Import the current working construction
# environment to the `env` variable.
# alias of `env = DefaultEnvironment()`
Import('env')
from os.path import join, realpath
import subprocess
# Dump construction environment (for debug purpose)
#print(env.Dump())

# append extra flags to global build environment
# which later will be used to build:
# - project source code
# - frameworks
# - dependent libraries
#env.Append(CPPDEFINES=[
#  "MACRO_1_NAME",
 # ("MACRO_2_NAME", "MACRO_2_VALUE")
#])

cmd_str = "avr-objdump -Sz .pio/build/ATtiny212/firmware.elf -m avr --special-syms > code.asm"
# for simple commands
subprocess.run(cmd_str, shell=True) 
