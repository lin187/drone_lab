import sys
import telnetlib

HOST = "192.168.1.1"

tn = telnetlib.Telnet(HOST)

tn.write("./data/wifi.sh\n")
tn.write("ls\n")
tn.write("exit\n")

print tn.read_all()
