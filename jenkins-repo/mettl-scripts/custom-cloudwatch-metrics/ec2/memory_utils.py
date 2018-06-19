import re
import commands

KILO=1024
class MemoryUtils:
    def __init__(self):
        mem_info_command = 'cat /proc/meminfo'
        (exit_code, mem_info_command_output) = commands.getstatusoutput(mem_info_command)
        memory_line_list=mem_info_command_output.splitlines()
        self.memory_map={}
        p = re.compile('(.*?):\s+(\d+)')
        for memory_line in memory_line_list:
            m = p.match(memory_line)
            memory_attribute=m.group(1)
            memory_value=int(m.group(2))
            self.memory_map[memory_attribute]=memory_value

    def get_memory_usage_percentage(self):
        mem_total = self.memory_map['MemTotal'] * KILO;
        mem_free = self.memory_map['MemFree'] * KILO;
        mem_cached = self.memory_map['Cached'] * KILO;
        mem_buffers = self.memory_map['Buffers'] * KILO;
        mem_avail = mem_free + mem_cached + mem_buffers;
        mem_used = mem_total - mem_avail;
        mem_util = 0;
        if mem_total>0:
            mem_util = round(100 * mem_used / float(mem_total),2)
        return mem_util

    def get_swap_percentage(self):
        swap_total = self.memory_map['SwapTotal'] * KILO;
        swap_free = self.memory_map['SwapFree'] * KILO;
        swap_used = swap_total - swap_free;
        swap_util = 0;
        if swap_total > 0:
            swap_util = round(100 * swap_used / float(swap_total),2)
            return swap_util



