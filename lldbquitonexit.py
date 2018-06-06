import lldb
import threading
import time
import os
class WaitForExitThread(threading.Thread):
	def run(self):
		while True:
			time.sleep(1)
			if lldb.process.GetState() == lldb.eStateExited:
				print("Exiting")
				os._exit(0)
thread = WaitForExitThread()
thread.start()
