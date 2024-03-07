#!/bin/env python

"""read a serial line (like a character device) and print a timestamp before each new lines"""
# Tony Cheneau <tony.cheneau@nist.gov>

import sys, os, select, time

SERIAL_PORT = "/dev/ttyUSB1"
FORMAT = "[{0:.8f}]"

if __name__ == "__main__":
    start_time = time.time()

    # only print on the first character of a new line
    first_line_character = True

    with open(SERIAL_PORT, 'r', 0) as f:
        while True:
            (read, _, _) = select.select([f],[],[])
            c = read[0].read(1)

            if first_line_character:
                sys.stdout.write(FORMAT.format(time.time() - start_time))
                FORMAT = "\n[{0:.8f}]"
                sys.stdout.flush()
                first_line_character = False
            if c == '\n':
                first_line_character = True
            elif c == '\r':
                pass
            else:
                sys.stdout.write(c)
                sys.stdout.flush()


    os.exit(0)
